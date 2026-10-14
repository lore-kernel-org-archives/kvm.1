Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151D1FDA61;
	Wed, 14 Oct 2026 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974351; cv=fail; b=Udx2i3jYgXMFP3Md6Hy9V1uu19relPOhzP+JQcQfkFvxRLYzW9n9IXo2fhntLn6LtxvL/GHkC37/SZa4ng3oOuQuLJ62mILPcuYAVFrLA2BL5SPisLDEYO19VUsZRad4m+3jqNUQsX6yjJXD3ic8GvP9HRijKMfmmOSSGlskFvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974351; c=relaxed/simple;
	bh=FSfBWAMnbV2Epx55oDkpI+Mg3Vzn14CM9z/eEs5ApCI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=epFDvnf39Qfnm8ncJpt5rlnjb4MWimEeuwbtDgZMb2yCYHCvXgWrUgwpAQR38ZrmsDrT1n+7sA4EKRwtANsfAqFH7FGk1JLp3mWmy9dGs6qnhzvIb+T9PYfZmtXGeXsD/SY7ppDKB0woju2ZUU/oPdpH21Zf3v+NbWm3BKUHl2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YgWMl5gn; arc=fail smtp.client-ip=52.101.52.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YgWMl5gn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZnenJrzwkF8VSAM6vBuQ8MmMuFpyfujJsDPBtH8q2zDXAO8FWHt0FqOuss1jsyrucYjoBPY7vULcAho3hCvQh4KuCvZzFo1UBwohSa0TeaPKxbA43P5JYWZZOBbmTd++3ibmtsUbZqTg4KDisUyGN4cwYSlUCnyHtmLVNHB6OqP78NEXeckJZY66+zN+48pU4YrC1KnF8RAFFQLSTKU8I12eDEF4HHgulDt5fIh1otecS/fGcH3HPU7t8XUmzfpu1sP44yCt82DoF7Ba81Afiyy6OdaS5qTsBGGwF8fTrOiu06EtLQfSu7y5wEXbzBT1+wP9Wl7hACcgyhXd7Kzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVNse8SvuN9LcR3FS4GHi3yH8W+eyB29ZWTohpuvapk=;
 b=yu1lCpc14T/TqKUAOQpFpxgOBN+w/iRvVNpP/1tDEi1lYAPUXYLiBHU0NNcO5aqrAyNZwtQgRKwTi+kqEFrJrxpDdVfnOXphFRV7QVlj9b+GlQ9kQmDkyleNfxH8WF0C2iOSnLRDiff1cJ6Davp/HwWh1uLvbVwAkdOU+xjWwUrFa4IPfDPv2tvGko9BwTBwz6cRmlokd8mrs3viI81cDoZ5EWKEEiJ8q2mevqQTRq2FyNcUBDn0N1FSt3v83g7Ze4xJ7uqvu/99xbZv9/jwtK7oBGmZM+/h021Asz6SPJ/BTgmbkYH8zHtuzvx40t5cHNHufMxUVVf6MgvxPrUITg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVNse8SvuN9LcR3FS4GHi3yH8W+eyB29ZWTohpuvapk=;
 b=YgWMl5gnqMJAUKcD4oq/kogDNL6LL8P0PABVYFEIk5WSYXPJWF66NWCfCPRpIK01nlqci64ja83XQAg/WoGiCxk0l31Y8RW9L8zhBZh6HLU8o++8NW+4Uk9H22FS+dUIFQosXIDDReam4uKw5G1WM5fPAvWh1SDBs6RfE1LBuOrJqasPh2Wm/B+TGj6lyd8TtAOFs+UGDke8qlF1EmZji4kbbbaQobqGA4kcC7HP9BFQjAvfaVJwkYlA9/qYewbekEthJFchFq8Q9NWfXThHWkNGTCYDwyWt3CBz7cTaqx3/iX7dvps5VpfEVXj9KGy1l2gKPcdz5dtmDZV+3zqIuA==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by CH2PR12MB4229.namprd12.prod.outlook.com
 (2603:10b6:610:a5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Wed, 14 Oct
 2026 10:39:05 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 10:39:05 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Andrea Parri <parri.andrea@gmail.com>, Alex Williamson <alex@shazbot.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum Thodi <skolothumtho@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Jiaqi Yan <jiaqiyan@google.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/nvgrace-gpu: Skip PFN registration for empty memory
 regions
Thread-Topic: [PATCH] vfio/nvgrace-gpu: Skip PFN registration for empty memory
 regions
Thread-Index: AQHdTQhsT48O9ljgGUuIzOvmQ3TGe7b1tT6AgARURICAAuldjg==
Date: Wed, 14 Oct 2026 10:39:04 +0000
Message-ID:
 <SAWPR12MB99926787B53C4FF469A6F3BE7AB09D2@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20260925161024.189771-1-parri.andrea@gmail.com>
 <20261009135203.33f3806d@shazbot.org>
 <20261012135842.152928-1-parri.andrea@gmail.com>
In-Reply-To: <20261012135842.152928-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|CH2PR12MB4229:EE_
x-ms-office365-filtering-correlation-id: 94d9689c-b844-4758-46c4-08df29df5e8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|56012099006|261009223027099003|11063799006|4143699003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 B+Twuot7Yejs78gh6gnP5kfou2d9o23+PYHkD0YfR3Z5tFBQwXw16awEvqIZjwMoP34jmPSUijS6ihKNBBqtoQqAo1HpvC1n0ExmTdFNRPdp0vHz+BPqI1S3vxsz4fa8Haj0u97I1rVlHbCiVpayCrbI99FOCKpKSEBx83b0MMhSasaeXlZYE1jkFSy1mrORWI1n84CrFeTkRTrNRTZxnE9hkt2m8DB37/bD2G/jAfadzpL63DzzjUqMCb1UXWa+xF0oQEBTigXm5Ap98m+tVbSy7/xTgHK5Uv1JM4kyBNDHMPOwVj2paYT5NFO/l1/9ezh7KzOhFnGGRVPCtmX1qd7GKDMnIxVuHif9Va4/fzkrhNYcblkZqdM70juRF05uh6jiqZp5vIHOGFDiQ0voZFzh6cs8pfVUx/gXoL5LWihiRvCWS2TH0g/sN37LoSyIKKOGAOl60KRw1mVa86qbZ4gY2zO2ENVv1qb/IVcoU5yHOj2OPs0RDfg1UzFpSYvAMh0eLlwJHFjp9gXM87QXj4sOQhQjFZU1wfmD1z+XkkOLIhtzZzFrA50ptuuV3feF1lFU3Adrr60ZZJUb8oX4H+pYLgDjZxiWcd4d0+MO+N9BKHN4CCnQBgfivO8L1vg1t6IREYoUD1/3SpKyPkx2rtVSsHxnPztp49RQetN7IrOVQX3TWt+bBt6YBK2s9sYthgOm2RihpIlVMLd5eO1zaT5OL508QTfoWWuKNtm6YYk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(56012099006)(261009223027099003)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EPnT6RfYsMwfE39m+FrheNqtLetmyLCnCsbIRtOjRWBmLm0fV6OO2bKWYy?=
 =?iso-8859-1?Q?mtWTSIYSFKaLfZpnRE+Aarx4aUkqJWTRXyZNJBhJlpQ2jSImh5Du3YgqeF?=
 =?iso-8859-1?Q?OOyxxKsykYgtH/1OVMvZSb98MAXOdFOjnU99xUd65TQSubcNVskewxgt4z?=
 =?iso-8859-1?Q?ugOO2jALXSAOOpBTIsJui75WEzO1Bx4NV821K64kHb4X6AfzjxM4srCClQ?=
 =?iso-8859-1?Q?+nN5gve/+YHWnGxYuOBWOy+7Duly17ODxlQok4ULlrtB5fOC53HJd5s+NX?=
 =?iso-8859-1?Q?tcYKVeafV+8G9p6O92VPdn+vy9zuTtDd4B/eugccY4yVNsDpMjbv7IHTye?=
 =?iso-8859-1?Q?9xI9u1UmorqWD6B6j+RkCmJZyuqnI8YIUUZwt7U7gXHgZzvzEvd89euuxU?=
 =?iso-8859-1?Q?dxLFavJJ+2iXU8sXefa3POUso7wWrK37pmkeEpfJJDo/Arip2aMcpzdqd7?=
 =?iso-8859-1?Q?3nRExpSAu7bQCMlv7kLCJ+q9bwSTJbVrDFXVblxuFMTVKbLlYbwlxYZYFF?=
 =?iso-8859-1?Q?sxtAlm9xuqXf4SzHPHT80t/rSHtLzG22ijwH6Yi+9QCUC8yfLBdKA+F5TQ?=
 =?iso-8859-1?Q?fD1XLCKz06uJDJZt3MajNyFRqtyrsC2xZfiJSP813JNeC0AZWCNR8kAwW4?=
 =?iso-8859-1?Q?SbuIAWPK6bqjxaOYQ5ZCe0OdBRnmRGTkENZrQEq1H15Sm3vpFUc809wQwP?=
 =?iso-8859-1?Q?BIbOlKIfp/++vtHHkVRKFdDpw8VXD9zzoG5/8Dp+fmhbOfXA/EVANhn8eL?=
 =?iso-8859-1?Q?JDbgksquCvA1ohrgLJ+ac1JldlAw0ChfKC3IZyntf/oTPyc47mrhlPHPer?=
 =?iso-8859-1?Q?VixF313C/8WIf20a8ZfaPAMm3K3QrkPLnwEpXGqsHegv7ej5+U9fg3dm0E?=
 =?iso-8859-1?Q?r4nfrqlE2Q8e12iD//wY4vHSeJm9XI+ml1c/N2+HJwo3EsT+RJDsgXKNCS?=
 =?iso-8859-1?Q?VtxEyO2IkmMc58xcarGOBRMr9dm8LiZjTyBELqFngv5+L1S2AlAUTxvXDo?=
 =?iso-8859-1?Q?Xloj8QDwhwGBngVBIK8hPAkQIUFVT7wbeVU0ABdFisTSF7IhgoHwIQenOY?=
 =?iso-8859-1?Q?9cSFCp+CGTbV7FJL1l6+i0E2bxfGFT8kHV3NjeG7xqwPaADEVNmgOqokAt?=
 =?iso-8859-1?Q?P5VJr5sD6W4BI1EDAsnOIfZp5M+9/dDrX1lBn7mTihc2AtsGJnsJIYnCi0?=
 =?iso-8859-1?Q?8LGXjnw3bFQWzOLyCb+8wQQpcpAjhxidIcALy9lNI5NCr1rwwKNvEbyIAy?=
 =?iso-8859-1?Q?lVbFT4WCrR9tMqFX06fFS2p+CO6xdBaAx0p8gliwQg+ihF4t0q8IOZvOxM?=
 =?iso-8859-1?Q?mps8pax3kLDmCRZCYIqcLmPGLfLnoD9S/y0iGmgYiPe3XzrlttDOsc2liu?=
 =?iso-8859-1?Q?+KQRrB5MWmBfrI8CRAz38Nev1ndydgSHGSeivi+M8J+CJoFIMIP12NYiR1?=
 =?iso-8859-1?Q?4Eg1rnpADoPzElfDHf12RM5TVQTVzlG4DCtO3PbcHBtknUNr/JyYtRc5bD?=
 =?iso-8859-1?Q?c27tW1VuU9sIBPejiJXTfPNOu7yJQOyLmpwGm+StnW5eBFp7CKUlO3sxNe?=
 =?iso-8859-1?Q?qHGCo2Mj4qgUiXlLBPPtOpxoM9ukXNhXIKOMBBWV7BuxMwyU+VzIv/o46N?=
 =?iso-8859-1?Q?GdyEWuDxFdTpetq/anWOTia9z+vmKyfMKpm73Ni27YyVjBsMVyPUa8yno1?=
 =?iso-8859-1?Q?ZvVRJORYVC0aZdJIVyJqjuPBPYT/87WtF9cLo3KeWsqa6gcnNCf7Lexomf?=
 =?iso-8859-1?Q?KNLtNiI8OCKmXWNkzWjt4yu5JS9ZIUtyI8MZddEqPNFhmP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d9689c-b844-4758-46c4-08df29df5e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 10:39:05.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VqRlW6cs0oCH597t1cVH8p0U/79RiNcNm/xCmEmNuD4VNThErRH0vxy1C+0JKjQO0rydHV1cdEj1PGNIfwvww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229

> Agreed, that's a better fix.=A0 For v2 I have:=0A=
>=0A=
>   1/2 gives nvgrace_gpu_pci_core_ops its own open_device, which only=0A=
>=A0=A0=A0calls vfio_pci_core_enable() and vfio_pci_core_finish_enable(),=
=0A=
>=A0=A0=A0to pair with vfio_pci_core_close_device().=A0 The usemem.memlengt=
h=0A=
> =A0 guards from v1 are gone.=0A=
=0A=
Thanks Andrea, and Alex for the suggestion. I agree with this approach.=0A=
=0A=
>=A0 2/2 drops the remaining usemem.memlength check in=0A=
> =A0nvgrace_gpu_open_device(), since only devices with the ACPI=0A=
> =A0memory properties reach it now.=A0 Not for stable.=0A=
>=0A=
> One visible change in fallback mode: open no longer fails when BAR0=0A=
> cannot be mapped, the same as vfio-pci.=A0 BAR0 was only mapped there for=
=0A=
> the readiness check, which fallback mode never runs.=A0 Ankit, please=0A=
> shout if the fallback path relies on anything else from=0A=
> nvgrace_gpu_open_device().=0A=
=0A=
Yeah, this should be fine. The device missing ACPI entries is not a=0A=
grace superchip system anyways. So not keeping the special bar0=0A=
check for the fallback is appropriate.=0A=
=0A=
Thanks for fixing this!=0A=
