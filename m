Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.155.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793042972;
	b=DEPeF8X5eKp8hDOeo+Cg9hEgg1/FiIB5EvCNYiRDMoSHbbjggrelzwfc8d820+2S88I7
	 PLBuERoc+2egzip0cqDTNLuWRMYQzgtlhCJcAz58PhsjEDK/OspD0xK5zt6Qjt+yqTtjP
	 2dhkMCtySlYTDmzs1YV4CwL8oDrmMO3bN88LD64phoey0w/cOGNMK3v9XuE0vph4/5n2G
	 JA7WmGcPIkc9KhB7sZ9fIaKebU5O5BpA+z6PPWDYa6q44N7axpw8/N8Zl1jEwpjc2IVzj
	 GgtW56EctK1uzBAdP5jWCWvt8TCFYTUrMmpdjo1sDf34eau5Kd8JSmcj66SjVo6VHrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042972;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-proofpoint-crosstenant:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Reason;
	bh=0Eo+zUzZ6pcORvKp5MXStjXa6SeH5qls4Bcg0GcH+RY=;
	b=LuyR3IHCVcdksbdgHCUfNPrrjFw606CpDf+lmwUrxsqJqd4TZu1rc2EQp9il6SFX9yaz
	 6Zr2GDEoJ1oHYMJprOhrNLZKSuCyftNbHpYoKoP2vXM4cz5XRq9jloZxOjPtSFoshyjF/
	 QrhfqLhp5jPAGuytEm9hJhmIu8oVln8I1E+p+EUwgxYM9PBRfMR5KNGEufV7SJkTq3p+D
	 o+tsifgRl9tyXAWyieA3NXsnaXhzt7+/i+mlKVt33Q+uuKB6O0MuETNgS8Y8LuvtBl0T/
	 7pqaSp0IbANhUzFDKukoh3K8DrMJckMi+clmSX60VWoWc0rKaOy+qrFHV1nqupIE1ng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nutanix.com;
	spf=pass smtp.mailfrom=nutanix.com;
	dkim=pass header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=izPzB4Sp;
	dkim=pass header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=Zhr6Ww3s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.155.12
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAC606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 19:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ACAC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=izPzB4Sp;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=Zhr6Ww3s
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QIo4cK1009704;
	Mon, 26 Oct 2026 12:29:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=0Eo+zUzZ6pcORvKp5MXStjXa6SeH5qls4Bcg0GcH+
	RY=; b=izPzB4SpsQEiBzpO15FRcEz+NDXpjdadimUkJFCRzj5BzjUt9ItC26oSB
	vphWFCH1yJlfN18hVb3EnlNqd4UC4R3TH4w2+uoUxm07TOLuf8J+1ECzqqq/MUPI
	UJPDzP9424SQf2VMOzWw2pl0cf1ZX+PQ0F1aBSytcQpNaL7guOQ6uGDSQkXD507q
	iMY70bSJ0oggtLZ7wJOjQoYMIUjQVPbubD9UdkHKZVfSiCerGlJ6e3WHt2XChUY8
	4QePA4CfbWsFA3fg86Uwtlh1p+u+LndC8kK8gCWg3LsaX2Ph6fs51wGtRb0tErHo
	2LVP2aWOQE4SBSU899ESr/lOyF2Ew==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022134.outbound.protection.outlook.com [52.101.48.134])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hj45qsgp8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG30SiEQAYZ9Klm+zkacpe+stBnbAmAhqeCG/lat8kAkkqPer7SCmxN1cfOLxjEkYmZcUYVbIikNwr8LEsUVl7pcTs1Tk3rhIWhfIUNiV9XDvgx9crsyoEVNKRpmalD7QmvoNbyeytBrEUL2pr/jZmuRQwt8IJFaaNvZ0EhCXkUoasxtPdvZG5b/+FYXGjE0VMyL6kAGaI7NTHB0BwUi5WfR9HkCcuQDlPVCKgGFtfD0lTaF/rtwwBNqNqZHTecAeBEVq0ZvaSA/BiLeIRuFJC1Tx5CH2XYNTYGStA0KcY5NvO1y7t1L2BfbA5pLAN4ADRN/4z1dQ+6UQYNLYPtx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Eo+zUzZ6pcORvKp5MXStjXa6SeH5qls4Bcg0GcH+RY=;
 b=KuKQbaXvNoQi9OwvsILacmUf6LL9XkI+3KW1x9ypOUMsyyMBpqZCxPAPb4yWxN1buX32iFaJ/7RAxY+LEGzoFpYMpQHRvvSGi9Sn3YS1FcdZQmZ5j8nOY0887EaAITI0M9lkuEfRkCTNtgl77lmsNzmiw7smP1lMZQmYUG0yw7Dwe4fA2Oo9Qbv6cMRvjTc5raKI8wep1BoKU/EEIroYS/hE3/xYHcqD6jBJS+3G32cX8Q/FwbNV47WCm44P6dIpjCRhxX38gypORVf9xh+IHgakNEvj+pivRFT0sB8HvuZvMSBs6xkp/H5rZRqoDUDZhmAArraq5AZAUP4uDD3tMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Eo+zUzZ6pcORvKp5MXStjXa6SeH5qls4Bcg0GcH+RY=;
 b=Zhr6Ww3sI91mCstHgg56j6dJDfoJQdGOV629XPw6dOFbnjGhD2LRBLIRE9+qN+zItDEapCYAr76Wu7/oELnQzvykbs2PHbbqgCszrSmWJvfet97sZ0YEqWZmBXtHTIy6ZIWu5y+eC3PffP6vRZ9L5mhWhpUBAfKLNyrJQ7gTpeRE1zV4bm1iW8wLY2FV1c1oMUNiZRj70GS2b9zi8xcd9Zh6mG5vopBO42ipYgSgqQSZ5263fpxBSVG5vFVlgrjg89pHu7sR/6//LGUrkLY8aSVb9Fpo87eJ9h0dwt+eoJe6mDCInCJLysAivLRiyJNZ48x0JN8qLnDR/eViWX7STg==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by CH3PR02MB071136.namprd02.prod.outlook.com (2603:10b6:610:346::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 19:29:09 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 19:29:09 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
        David Woodhouse
	<dwmw2@infradead.org>
CC: "seanjc@google.com" <seanjc@google.com>,
        "pbonzini@redhat.com"
	<pbonzini@redhat.com>,
        John Levon <john.levon@nutanix.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [PATCH] KVM: optionally post write on ioeventfd write
Thread-Topic: [PATCH] KVM: optionally post write on ioeventfd write
Thread-Index: AQHdSplnXtWCtr4qFUWEUj3nkP4ecLbtojgAgBDLewCAAKGNgIARW/RA
Date: Mon, 26 Oct 2026 19:29:09 +0000
Message-ID:
 <IA0PR02MB946211902E5B59DBC778754C8B612@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
 <20260922135102.GA24134@fedora>
 <c18ef5464ff4fb4d607c6ae02c58024b41b3f17c.camel@infradead.org>
 <c213ca93393bffb774ac1642a4718f91a4c14891.camel@infradead.org>
 <20261015182208.GA1504100@shajnocz.csb>
In-Reply-To: <20261015182208.GA1504100@shajnocz.csb>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|CH3PR02MB071136:EE_
x-ms-office365-filtering-correlation-id: 0793bfb3-b83b-49ba-d60c-08df3397682c
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|261026121527099003|22082099003|18002099003|56012099006|4143699003|261009223027099003|261021121427099003|261022105027099003|261026140227099003|38070700021;
x-microsoft-antispam-message-info:
 kiPzUErTRNWvWYrhNpIWJm//zgyBJW9IMfWks9IO634EzfTL68UkRVNPzDSbG/3TaQ3B1qEdrNTMkDmZ4e6i7Fnq4QOKt75FXH/S9dZlAKmf4fTjNQ+6KWkNJI6SA+N5a5DTzedvBAI82H6DJXU7trYdeVstctap/Nt2PlRu+wDCmOJw7uMhqZ4fLqk4wcVjPfnHoUxc4KcBdw9eMhjTSa4xJ5mfueZGBVa2rdumxo+AtACnj7P71Mx/o99mSW88qR5g942lZUWo/q1mw90hNadfzR/mDeyHXNEaT0V9WW/Q9VkJOrXUEU08h2fXmeY/ouQGASedZIlZsD64GfFOr1Hn2eEMx7bPO7e/2cOJEu7uFKDQig2WKuY0qEkdSkVfZ0EyLimE0jf/YY7X4UyFAwyHt1JR6V3sI0zBhMfVfiIa6tRoWMvOGroox0TB28WlZkg6slzhAkWLrXgAOcsfuhG2uUSpxjqVIkjjFxffafyb1KTYcvBp8itKMqt+ddRXDaTLVhMgvZBORoy0ABk1l8OqPAiaXTaW1oYCSG04vWLoQqwf3EYrTDJ9Mg/7HcUXP/LMq04SvElBOfFjUkPMmi1y08jBsGYVQivspa55UG6cG8WdF/RKCuOcY/+2OVR/PH66dEtjBIRiV0fXZXNzf9OhCqUStLgj//GOAAaDoK//TwBe8UC2SpF30kjA7FwsUuAPxIeIfWYeg+b995EYlaHOt6tCygIy3ZwcCVD387A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR02MB9462.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(261026121527099003)(22082099003)(18002099003)(56012099006)(4143699003)(261009223027099003)(261021121427099003)(261022105027099003)(261026140227099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EvoSpf+mLkiiay8C8pW4JjMeD2CXVZtCgcz0jkViYrxwlizXbAonDZymt0cw?=
 =?us-ascii?Q?sgJZ6NQCcEu5lLgsinRAXAAM6+i0BpOdcfSZDkS/aBqO6Fit1wBNGo83A0Me?=
 =?us-ascii?Q?zn0/JkM8o2yWrHQsC7Ck/eROv56f50HwaFIR0x2ZBeB3dFRIkjjJnKqnhsxW?=
 =?us-ascii?Q?sgsSlDtA2yJ0Qig10O+jK4EjSa3cHx5NqpWu2mi8NTEMfZyFOnOmhBCiY7im?=
 =?us-ascii?Q?kNRbmOk50CtU74TCkjp3hIVI+1OU6uWuvi+drrqIPYSBCnj40CWrZ9s9tW9e?=
 =?us-ascii?Q?QYe2ArUfmerSxyH44nM/ZdMnZHQHeUH7R3U0u9JewZzWoYnZ3gy2lJUJ40pH?=
 =?us-ascii?Q?2wnRx84IJ7jsnK+4ZQQnhFL5xtDyxBibu7Op29Ejx1uzkaJ9vTQz0JX6m9yh?=
 =?us-ascii?Q?9CEdoCeG+rX/trpcF0nSH3O1XXMxSabe1eFJLW25BBG/C1hIwBLczTZ5yONA?=
 =?us-ascii?Q?hyDFy9SOPooBp0EYIgLc+7gTpf6irt5KXGTy8/7AB9eN3z0oK+G2yqe2ahHL?=
 =?us-ascii?Q?2+jPGd5Yi50CAuWdJYt8iXwgmPQeP/AmTtTw3QA1krAnDL39m4tN2tBGo/DE?=
 =?us-ascii?Q?LgOCWbrD8k4zSTSpJiUWVu433eN38svNPz6luyqtxGTn5JUzmtHr/RFm/YvP?=
 =?us-ascii?Q?mbC94atmFbTpkGyQcsDLJYEc1NoYGy4PU23lSE14IP64Hkzi00XRD/Vs1NAv?=
 =?us-ascii?Q?tRa0MJktXq0qnPlDaHUxqhdYkq2nNUH50tFzjigRHM4XuCxT1wFmyrsfuFb0?=
 =?us-ascii?Q?v2Vz7FKG6ToYyY6S3CExOnEt5aqcoycFclh81p4YuHZbDBG3oKEPr2mdB+vL?=
 =?us-ascii?Q?FUFt9ZNCGfNaebfeu9PbIrvn9YeTuZuL9pQF4GkGE2QEvNRBZ5kxLPHNgD5X?=
 =?us-ascii?Q?imE00RJ9FgyUurzxPVj59Eupeilp6DSma0ZJGOKLZqkZ/ZR7SlSbmKPkUZwV?=
 =?us-ascii?Q?2yXdcTtVSzhXU1GECLsk4+Wo6g1X4uQY2HqLXqai42GZKTfYoN+qLyNapqS3?=
 =?us-ascii?Q?z37i7Tdg2LJfa9ThO+cwNwWW8rEfLN7P3Nb8NMBxeCxv2axU6srRpSifNM76?=
 =?us-ascii?Q?3lQe1r3Cz0hbn42J1o3CttsjxAVpKXmmnBMV7fHObCsdd9qzFo2JMQo3AwVy?=
 =?us-ascii?Q?qKSjnK/xVemg2JHG2I6t2ZeUrW+88bSwA6sUSYUm7lWawCTvy3ISt4aS1KCm?=
 =?us-ascii?Q?SSyBIPDCON/WQ0Ay4PIRInJfE4m4w0IT2SPXD8NDRpQCbZhmUKoxWG7H2tOC?=
 =?us-ascii?Q?EDHPMzaeCjh1yH1q5kBZi/sdbcsY/1dS3veJkbaurQRFWNXZIvd05AdON9g7?=
 =?us-ascii?Q?qhL7Ew01EDln7wny46lq0flIrlZuvLmXfiOOve37o/BlhaB9ZDimnF4BIiky?=
 =?us-ascii?Q?6kaATsbAKB5JGQsSQHz3S3AsBpfE1pgRNAPjFGoXOLWIRIKYHMLv96ri3MYB?=
 =?us-ascii?Q?To9JpuEKzdT/lmCz7PPFcTcfiztst8VVPILHH03dJnZ41PCutnLWwLR+evzx?=
 =?us-ascii?Q?5Q70+YYYBy8SYAgwWniUM5kWTA9sOnVxnv3vRBBJNDOfuRIYjauPIEaVaWfQ?=
 =?us-ascii?Q?D9wabn4WI2/eYyvHdCjvOBgRjkNpNg7m1Bz6gt38AC6HRnkgjPYTxUXmiNCz?=
 =?us-ascii?Q?ruWD6hANO6AzK+FiMfQqYQEyfXDZqSvvvGXVSiF+S4qpIqhJCr4b8Fy5iVSJ?=
 =?us-ascii?Q?GX2S65c4Ch2XAWX2BqD7USO5CIDu6D9XPJStI/y+taJC8oK4En52IO0oTReD?=
 =?us-ascii?Q?+/U+oJKcfQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WNYJ9yK9yg+ifYrEeHEWPtBi7Z7q59cjLn6WTS6BTwEf1skesu4hUaSniYuQI3/KZS8V7ePQfse/M2rKHUygTzgMQ8lHdtloBHDNa5Knuvfbv9MDjCBfTm5L0HAHMXF90EykIeP+cbEgIbf6xzajdbsR2wtz8InzPLxtEMqJhGnyXBD8XcrSqWy4Uv1HAdhR/bLs/SVZdjRiSs5vqS4oYW2i0jgKkNc65RdAguwQKGj4H+v6iWXkD2KxCXQDEobzYefNKHT1Y4AbrcZfcVPo6tiToAFNxUucU0xxMel6lRbuzvC6FfVow1+gYW+72iH5yFSWJgBvqjEIriWoNcsSrQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0793bfb3-b83b-49ba-d60c-08df3397682c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 19:29:09.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhLyW0m/VuoLYwiQG5ZPg4Ks1jAs9ulqFVqjeJck3a7dF1xkzjw+GcV1dgk1HXkcb2MhJI+w4FwNGvjqu0BxFZzVtAq5JFox8AFAnPeIK5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB071136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA3NyBTYWx0ZWRfX19wxaGD8164Y
 Rv+rZH0UmLIG8vqrKPKo3qnP9mPJFljhSJ/sY4XE1lUVLgP3GwW8kKu+oU776oRGFiZbDSTLOHL
 65M5CrxxUXgWhzsG5g0ohd6zR/omBnK+eJOT0OsTpEcHXhj9wIADJh8e0nH/KDq+ogChhofZu0m
 6bFvZrgItRTA3ZXfZhmCniLFW0qN5vqwVydVVEQHKxEUKMa6jP1ajXouy2lghhLv/lxY/tHwBln
 TaHlt0LvW5J67gMg+Hz/dg38pRGX+lWsl0B5gG0RC9JilCMIi5eQX0Yd21Sck3lEYiqAsKoqpO1
 5E4S8hXTBfFvpmXfFioPaXn8GqVcDvJj5bPitOh1PO5tugdik6lSG6xZ+AHpvW+T5naVyinx9Km
 PTCP26yvqvUZ8QIbIR+Sx+nW3pyzywORA1vaMVdL55T6DRlY86LX7v3IGXEqODNtDG8fM+UX2E2
 1Wt9YJv8eJnOPEtsYiA==
X-Authority-Analysis: v=2.4 cv=KJrPn1Fo c=1 sm=1 tr=0 ts=6adfaa09 cx=c_pps
 a=xo3zWrN9qLO3Lphhql2lSw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=20KFwNOVAAAA:8
 a=JfrnYn6hAAAA:8 a=1XWaLZrsAAAA:8 a=64Cc0HZtAAAA:8 a=VwQbUJbxAAAA:8
 a=87Mi4svaThaIi1V-7AkA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA3NyBTYWx0ZWRfX8LtUMFVH/xyN
 uvJARt6w1AC//qCJ3WJzZn3QWI6LnssAzv+hm+wEhO4hjWTNWcO4nkFOGZ4ku4KtFUvD9gqDhMx
 w4uAe+GAISbLXn2t8Q+PjuWIDpf7Q98=
X-Proofpoint-GUID: n_zIX0888ODgEy1YRvQq08TBX24QW6hz
X-Proofpoint-ORIG-GUID: n_zIX0888ODgEy1YRvQq08TBX24QW6hz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

> -----Original Message-----
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: 15 October 2026 19:23
> To: David Woodhouse <dwmw2@infradead.org>
> Cc: seanjc@google.com; pbonzini@redhat.com; John Levon
> <john.levon@nutanix.com>; kvm@vger.kernel.org; Thanos Makatos
> <thanos.makatos@nutanix.com>
> Subject: Re: [PATCH] KVM: optionally post write on ioeventfd write
>=20
> !-------------------------------------------------------------------|
>   CAUTION: External Email
>=20
> |-------------------------------------------------------------------!
>=20
> On Thu, Oct 15, 2026 at 09:44:54AM +0100, David Woodhouse wrote:
> > On Sun, 2026-10-04 at 18:16 +0200, David Woodhouse wrote:
> > >
> > > FWIW while this is sufficient for implementing i82599 VF
> emulation, to
> > > get line-rate TCP *performance* I also needed a directed
> yield_to() to
> > > the consumer worker thread when it gets triggered.
> > >
> > > And to get line-rate *UDP* performance I needed the consumer to be
> able
> > > to arm/disarm it, to avoid getting throttled into lockstep with
> the
> > > guest.
> > >
> > > I'll clean up my proof of concept hacks and post them after LPC.
> >
> > FWIW after a bunch of other performance work on the emulation it
> turns
> > out I can live without this. As I was preparing to send a version of
> it
> > upstream, I did a final retest with/without it, and it isn't needed
> any
> > more.
>=20
> Neat, were you able to still use ioeventfd without POST_WRITE or did
> you
> take a different approach?
>=20
> We ran NVMe emulation benchmarks with QEMU recently and found Windows
> guests need ioeventfd POST_WRITE to get into the ballpark of virtio-
> blk.
> I'm still keen for POST_WRITE to be merged.
>=20
> Thanos & John: do you want to give the patch series another spin based
> on the feedback?

I'll respin in the next few days.

>=20
> Stefan

