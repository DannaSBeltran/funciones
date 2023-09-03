create database AirSensePro;
use AirSensePro;

create table AgentesC(idagentesC int primary key, nombreac varchar(20));
create table Empresa(idempresa int primary key, nombreEmp varchar(50), Nitempresa int, DireccionE varchar(50), 
telefono varchar(20));
create table Usuario(idusuario int primary key, nombreU varchar(20), correo varchar(70), contraseña varchar(20), idempresa int);
create table Dependencia(iddepe int primary key, nombredepe varchar(50), idempresa int);
create table Sensores(idsensor int primary key, iddepe int);
create table TomaInfo(idtoma int primary key, tomaA float, fecha datetime, idagentesC int, idsensor int);
create table Mantenimiento(idmant int primary key, Tipomant varchar(50), Responsable varchar(20), fechamant date, Obser varchar(50), idsensor int);
create table Meteoro(idmeteoro int primary key, tipoMeteoro varchar(20));
create table TomaMeteoro(idtomameteoro int primary key, tomaM float, fechaM datetime, idmeteoro int, idsensor int);

Alter table Usuario add foreign key (idempresa) references Empresa(idempresa);
Alter table Dependencia add foreign key (idempresa) references Empresa(idempresa);
Alter table Sensores add foreign key (iddepe) references Dependencia(iddepe);
Alter table TomaInfo add foreign key (idagentesC) references AgentesC(idagentesC);
Alter table TomaInfo add foreign key (idsensor) references Sensores(idsensor);
Alter table Mantenimiento add foreign key (idsensor) references Sensores(idsensor);
Alter table TomaMeteoro add foreign key (idmeteoro) references Meteoro(idmeteoro);
Alter table TomaMeteoro add foreign key (idsensor) references Sensores(idsensor);
CREATE FUNCTION ObtenerInfoSensor(idSensor INT)
RETURNS TABLE (
    idToma INT,
    tomaA FLOAT,
    fecha DATETIME,
    idAgentesC INT
)
READS SQL DATA
BEGIN
    RETURN (
        SELECT idtoma, tomaA, fecha, idagentesC
        FROM TomaInfo
        WHERE idsensor = idSensor
    );
END//

DELIMITER ;
select * from ObtenerInfoSensor(1);