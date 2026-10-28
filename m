Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.155.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793204555;
	b=klgS1OFz5fOrv+by+kFDANFT+tU9V9UNbTEgLg6o9JmlrCYQ8dN0HXQ2WK6clb+0dcOM
	 PmsWs0t3KD0wXCDNiZmdAmG7MmP0yNZITTgiAxPof3aK9/FG1j7yBskh/sI9vah7biTBl
	 Bby7+YQY66DX3xcxjj9sD36gFYP5xyfa2H2dT0ANrM3ADajZJRvyV0sxWLhmrAx8RKfWA
	 rV3TyZqJA21yx+qvzZPYGwPuva1PQyFd6RSfsMkL2FVBy4gC6EbW6Zn5ZbGbEXrkGUkRY
	 YWL+H/IU4nuXnxXC5lmpfiAEnHrA72/k79Z6eqP+GTNtQy5ZPgIu/RDTs6g5Z10ZEgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204555;
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
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Reason;
	bh=Xqh8qrOrM0Gt+56uhNv/V3T38uSN2qbAGEdD0ME39L4=;
	b=VwpWLtfCTjlUeTOOHIHyB3vQjmBFFbj8gVG3tf2i64SexT6Gg5jOJlsKTJJBm5nXUZJ0
	 OUkR0xjbGzMYTGW5FoQ8YuLXWlmf4k9H/fs35snfDJZyf15e2Va3XpAonTSGuniEkPOJn
	 JwuDMB6J0xY4EhdDExSxqlNtRo0Mjd8tMRdANUTFmNrVW3+znqtGhIBpsTmOp4llCRgyP
	 5imQYydHPmM68m/v3J/F/8Y6ml3Qv8pf4nJvh9imSiRhNJy5ud/2cz2yLoBB/PcyqiAmI
	 GAhZB9FN42AlSfdiqXm7CTv1/rPRTTSxzMxeH7hJKHyKGS9SfV9qA3A7FHPv2Gk4deA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nutanix.com;
	spf=pass smtp.mailfrom=nutanix.com;
	dkim=pass header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=mW6MzSE6;
	dkim=pass header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=tqP8oBi0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.155.12
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE83606A327
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 16:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE83606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=mW6MzSE6;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=tqP8oBi0
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFAect1099543;
	Wed, 28 Oct 2026 09:22:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=Xqh8qrOrM0Gt+56uhNv/V3T38uSN2qbAGEdD0ME39
	L4=; b=mW6MzSE6G4VcT22MHNY+zVNK8P4Zd8qYN6Wpw0MzmPx1m3OH8pgUFOklO
	PHrw/Yny/MdrGsBUs8I3zMSOPh+Vw16LMbX/20KbIXcKsXB5d+QsCcPEHL9+DjGw
	zKJq0CAAtxocmndYlkdhGeFq2nrMPCsYiC6pa01/EwCkeY5SeZfuUitCUU3qeTyz
	lzWK/E2myLI3wl3genLkHt5XldkrWtEwyS1BfssxZWWNchBriz7elNDbdmgFCsOY
	6+Z9qR9VTSqE22RIzJZ3cBlHQKPW6mJa6xWSw7hsHnWDIz18K/Ur4KtqlhdjV0rg
	WaSPeG1NGQucjUEEOe1+zYP4pQkjQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11022105.outbound.protection.outlook.com [52.101.43.105])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hk40jt8yc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 09:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMqDCqYZHvDWOx9NTE2WTqIyQoajGppydMdWj1+j2mFzM43wFUagY7ZxWQkHVE5RrkroOiYXV++BOzpfZ9DualWSgI3yPLNyQuZHanAClRswBtMQ7+FKVynC8ZJagsDf+TgJ5HgkGoudOCulTAtvEaBg/3+4fBXEktMTaqi8n7S8EyiDtf850rXHw3253sZ7pGLNd/Blt9Pn2oC52uvD5kqUfIvIVIdq8/75mY00Zz7P1koEeAKAHV7rqHzasGcA0cdslTAK3+CAzzlALcAljCGxxqwc1r/X2NSxkcfXJ0NnbZxUbBwyP45pJIE5is8Hv2AiIWCGvaQpITingfOZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqh8qrOrM0Gt+56uhNv/V3T38uSN2qbAGEdD0ME39L4=;
 b=gQJfGsYGxMeOPEGN0nVJuNykjKVdgJudhFfYiS/xB+gG65i5+nKWnyEwvuZx/arzoi/9bOTZ/rGqogalcuwJgC9MM7ZQWfzdhLpDm37ykKg2r3LU16jx8wF2FVQ3Jo7g8I14OCaR09GIc7QMHstPhDtMTZKKPVTPVaBNISG0iFLHpYAdSqcAzr7vmXx9BsI3KSQKvT2zsqKaOzgCXmHm2i4WjoAZs/hY4h5wEnLVyeROoYWNMH5v1hOAihD1/VoHuMknznq4L999i132CtYzAmSTOosaX8g/K5j9f9ekbJLKqArU1DeNYcXnNy7nji32dL44Z+0cacNUY/i72YkkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqh8qrOrM0Gt+56uhNv/V3T38uSN2qbAGEdD0ME39L4=;
 b=tqP8oBi0JAsOhqdYnScb+M+8DBbadNzb+DgPk3XkAXfNZQik8ba83Vdv2XCP4aRvIPGQKSW7cgd5PRBcfsNCBqTdU8MjBmBpqCsOQCheRSlXL7FvUuZY/0GgeHmLM5PzHwP6hXhwF9FSZOsaMepxpo9bHin5HkcqKJpiFAps68wTaWeXrBcYz9QroSGAVbbO4bw0BBDmdjHKQFiitlv8KOZVb+aepUe2Lj8FETqUkLw/E1Z31WbFEFJm6N0VZ+wbzeJKTLnpnFVeLK0WwNb/bkCInkLs6Ti9OZURYqclo82SquZ9wdrrd/zhmyDfqoGSqbxk8IfJOihKur5jAp2FWA==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DM4PR02MB9238.namprd02.prod.outlook.com (2603:10b6:8:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 16:22:06 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 16:22:04 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "seanjc@google.com" <seanjc@google.com>,
        John Levon
	<john.levon@nutanix.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw2@infradead.org"
	<dwmw2@infradead.org>,
        Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: RE: [PATCH v2] KVM: optionally post write on ioeventfd write
Thread-Topic: [PATCH v2] KVM: optionally post write on ioeventfd write
Thread-Index: AQHdZj5QxZfCLEMxlEOFylWgMTLaDbcS7o+AgAA11GA=
Date: Wed, 28 Oct 2026 16:22:04 +0000
Message-ID:
 <IA0PR02MB94627C3FDEA288A0872861B38B6F2@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <arK05GrLtiBvbfmm@google.com>
 <20261027180903.1008-1-thanos.makatos@nutanix.com>
 <20261028130911.GC1217203@shajnocz.csb>
In-Reply-To: <20261028130911.GC1217203@shajnocz.csb>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DM4PR02MB9238:EE_
x-ms-office365-filtering-correlation-id: 42a955da-bce8-430f-7916-08df350f9ab7
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|261028144727099003|261026140227099003|4143699003|38070700021|56012099006|10067099003|261022105027099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ldJQgh0skD6+eS/6iW5KrSZlPm7aolROFHm8C6SvON6aOLSVS38kb4ntlmqsXBx3bDD033VE2VJvYuQe2ZMQSDRbWXkUp1EiMUdEbx/2+IB8aP7Ye68Xl24XgX9hf2x/feilQyWlk46kZ93jWNwtIGwSBN6fR6BToKdUwCOFD8EzXXki/xUOB0dKW4Qr+29U91F9P2f1WvA6k/f5+d4uvGNzgTSkMhDU+uhdm5IQsRKmymn9wM+j8C7QkNTnts04NelbhqXohJ/hj40MDJOCcnW5wkrVOOIyrFe97KcmABuXxBVX/mjs23FRXUN6lIvoSoVEYvhqSWVNgdDmGhHhTCDyppTZUwcQnSOwkiwFRTZY+DddXASCPDRfF1tK/MXtADEdJYeI6yRGTzUGfRj4Tc6VfNgO6rBgVMXoKv1/annH7JPK+QGDsu35rRd8BuBQB8T343MML7hQ1ijP4g2gyzOr5sOfApqKGvK6aoVj6/LNIfODD3STiBPjN48FQJbE4vmy5oViXkJZ9BqlcGg1ZIqh/MSCV9CrqsKyWAVB7A8cpgVOCrfh6zWlJPCkPfD9hpmT69lAkQy4Btvylj6PueVFO2U0udVW8yQWh0XDpthCfcnIgbkIvRcVE8CICDBD0WZEkxJil1sL2g/+HJV9x+ULp3eKra1CsP7zfysKbhap+Lgi7YrDnfyo19t6qwFIK7qpH5yWG7Rg5uThy94+DDJwlneQhvCp7fAeUjNLAjQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR02MB9462.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261028144727099003)(261026140227099003)(4143699003)(38070700021)(56012099006)(10067099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y8ZFp6S8HJfJIrlswm/4VOk6SgqUAKvwZ2PH7SPhbMq9heovSd5LpBE/8Ghn?=
 =?us-ascii?Q?wVXaLysSTzxMdNQL9F14uYrehg4ItIdu/1stj7HvYsIuDYmTmxzowQmqr2fl?=
 =?us-ascii?Q?egbfXLPvkOX1zbuuoBaHwQyPis56om7tRRMI9cXDrM3PZc0BHqfapfEQxoR+?=
 =?us-ascii?Q?YbzssKwQupAaful7GZAPiSiyKwVYJ9doxMJDkb5qJWSM2yp27HV/AWB59+Cj?=
 =?us-ascii?Q?qVGYRzeV/rFEH9bK5eDFITmrisLePNyVtw2QEZ/2NZ65EwJywRvdAFOo8B2O?=
 =?us-ascii?Q?KNQ15wlXZW4YyF4Xc4T9I9bft4Df3Fb+Stdets/yUiRJxc9u9RdUHouCARGy?=
 =?us-ascii?Q?NoyoCJny8XjI55JHf9K7rMpzQzSESJ4Wp2R7ikZYx2w0qRYAyN9cPeoWiwGm?=
 =?us-ascii?Q?J445hRyouiaFF5CQS6EqKGxJTogUnJdBhb/HBvayVfTJeOB3mHq7wSSlCFqN?=
 =?us-ascii?Q?sN8VpRgDfE8QMpVYdUFuPEWUnK+7l9rzGof8OcVbfZ88h7Vm+K34SFRnmC5J?=
 =?us-ascii?Q?V6n1CAcHxr5bpQIHzqKka4PuqnU/Ki1IA7Xp/v/65CMuQP4cyM3g94KM6Hxq?=
 =?us-ascii?Q?o+O3xMdEh1LkywM3yEm4HnZ41nJYooaLq3i80e8AV3jbYTO2DuxvvhBJd8QX?=
 =?us-ascii?Q?WNy3FBfuzla0BHDshX5tPYdsXIQpuiHYrjQrgJDSKyV8ZUicDPj56GZnad4u?=
 =?us-ascii?Q?cIGRRUWsnQpvCtWp2nZlDrnYie4zJIfdzzba37O2QR8Yje9wVk+XDMQPZTNa?=
 =?us-ascii?Q?yGmSWrr4cFnQ661iSbMHJovV6Xsd4aKW53FnhO+kZDjI3dmmSeVSm+rtzZYE?=
 =?us-ascii?Q?h7nWVklymkutmJ4PniUwTzsp3xo+wm5842OSfhclYinq0+mDyKaSDNTS5lif?=
 =?us-ascii?Q?m27Qud2wI6TybXk5ydaq9nU9COO93iRjILdd2awerrBx5j6JgxsytSkl1SzH?=
 =?us-ascii?Q?w7w5k+PcMUVtoHnUMuviocRBY/ChXnqiSA4/g8QY9lH7kQnV+oRplrvbSj7m?=
 =?us-ascii?Q?bEi657j/+qSQgx6ztXnrvPUYkv24ZEoLBuO57oV1SMpjULn754WdOTUTPNIh?=
 =?us-ascii?Q?aPIWkRNTdnMzFYQJXY6dMP3fhcm2Zk3XLhEKzFfdjOygbZYAHG2ssd8SXbnq?=
 =?us-ascii?Q?XOgixNhwxl5wwDq+Llml0G7PbcT7YfBmZn3XJrZTA6grbvXhTxXnHK3ltdjt?=
 =?us-ascii?Q?WOR6Yu/QYJPjUPhYw/Su3HsyZDnlhioMLQQyeXFFhfP27XjQlKv2TBW2g/CC?=
 =?us-ascii?Q?Hs2qViIAdfWcO0DmppHYnJmQtcegt0y2Zmj86y5y3EHv5pndrQYuCPaDF+o/?=
 =?us-ascii?Q?8gfJfezsojLe35rUFhcnRTtBBw1jz0YiuRYnfWA7gMIc4Lnr0vp4osS8Y+d5?=
 =?us-ascii?Q?d2NRKVtAQeNvS/f2jDLXHU5u5w9pNGI6qfuwLDWvYViSlhC+ht9V6S9Kvtm5?=
 =?us-ascii?Q?xW2iXtX1dkF3c7e5U5rRt22YkuwGv1n+y5hkXpQqG/Jiu19Ra5jXbypxfgId?=
 =?us-ascii?Q?M/iXgRfokft9z0DDX59GTFilOpCmOhyJkJzAGLvF+p5po+oTa4TJ7dqJsSWw?=
 =?us-ascii?Q?sk5GFFLL0tB8ge8mgrW4vrdCak3/G20g4D+WWXxeZLHfuEts4ctz4nvCM03w?=
 =?us-ascii?Q?STEwR4QFdRxSmnmhjcUTiRODl2N3YiHjWFaKYK6FzvleqP2RPg9P+q90RnDR?=
 =?us-ascii?Q?zAwGpUODfgSrvVAMDMTTrLXawHORfTrseSH+tayhJciO4zxZkKoLT6IMNLMb?=
 =?us-ascii?Q?PNO1r4pfkw=3D=3D?=
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
	sfYkmi5yWTp83aNjTT3KVHxEwZpBeVeLiiYJ/LFwU6+cGporFc3K2TkR6qG1J27rOPtnO29IM7Yp0swdjpHeXS9vvYpiYMGwt4KXagYTkOiwYgoj83lfpeEDZ6lw8NuDYQbgm9pRoClZBr/V17cL3Px5J6WarUZK5O17To6za5hsTREwp1ZDCG/5AhI5CfRcBbnLiNFjdMKP16iEsyTgRaxiTIulAWMAUhKKeNPm7pqBoLE4caAob5wPdC4PaANZ6oOTAdFULzyX9lF9TpB3avvJXtGLOpmx95Wu7HEjVlLjvk7oPbDDHBoUj/iWqcnABeWutyl3odeOwxabcHRQ8Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a955da-bce8-430f-7916-08df350f9ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 16:22:04.6107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aqTJEnaMdyRg5VHUmFsmT4OU5+cw09jeCkRQwQ48Vmzv+aUwZsacu+fQsOa5ScZCRbm+Syt8y0lvGkTjS7tgkmFUcSE8a8nClDrBRYJvcIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9238
X-Proofpoint-ORIG-GUID: fnIZOAmmtmM38HGVebIdfsDLVfad6HeT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2NSBTYWx0ZWRfXxCEhnrb3HGvu
 o/b8dwZOccGsvZ5zvEbBrPtw5YEoEkPV8LVjz8N1dpfUuPupvwugJWEwCNqpGEul6Rd1O0HhN3D
 1apz4dcN7I1nqTDBJ3OTEWbFqwTn6vnTvXxAAsqu5tfQ18SKTASd4qqy9OnIGisdn9DO+y2bQH1
 a6TCAHuC7FjKY1eHIsKZaJTVmBizYSeK6+Rw5My3q+7ikEOhBp3UOAWs6YfwpoSi+Rm7VlorBwh
 wQGnMidTJXHzC+gH6LYzTcJUP1kZSNJ+3v1jC9UGnTraf14DuduaITH6u89hOnw/wcmhLPito/v
 kQKUQmwDpMKheNAVVQfAIN6WV4XThxSKSHuBE6Nx6YRQVGsE/fPwtQ6MK4cplkOsymnxUtHWi7q
 Ze9ttQpfu89v9DU/H8jNLN3IDW3e83nPPFAf4YsKFUBSbWifFM0f2TEDcnkmT2Qhw5lRxqUdf6x
 J1qpTnZDofdjN4U9Q9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2NSBTYWx0ZWRfX0vQaIKpSEEzh
 xTQv51rSaAoyHaitjah1RA+X2VxH5pRzRUuQ1nqggIIQX1BoVEF31MJLqOpKiKY3lvxhTfgQHYx
 nCh9JGjum9ANlFXK5rSP9fpZgNzTYuc=
X-Authority-Analysis: v=2.4 cv=S5lMU4sP c=1 sm=1 tr=0 ts=6ae22136 cx=c_pps
 a=x+YQLAOB2Ab8tpUMZgnrtQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22 a=20KFwNOVAAAA:8
 a=64Cc0HZtAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=zMO2xbQO6AxYZx-bgvMA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: fnIZOAmmtmM38HGVebIdfsDLVfad6HeT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

> -----Original Message-----
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: 28 October 2026 13:09
> To: Thanos Makatos <thanos.makatos@nutanix.com>
> Cc: seanjc@google.com; John Levon <john.levon@nutanix.com>;
> kvm@vger.kernel.org; pbonzini@redhat.com; dwmw2@infradead.org; Mark
> Cave-Ayland <mark.caveayland@nutanix.com>
> Subject: Re: [PATCH v2] KVM: optionally post write on ioeventfd write
>=20
> !-------------------------------------------------------------------|
>   CAUTION: External Email
>=20
> |-------------------------------------------------------------------!
>=20
> On Tue, Oct 27, 2026 at 06:09:30PM +0000, Thanos Makatos wrote:
> > @@ -811,8 +819,36 @@ ioeventfd_write(struct kvm_vcpu *vcpu, struct
> kvm_io_device *this, gpa_t addr,
> >  	if (!ioeventfd_in_range(p, addr, len, val))
> >  		return -EOPNOTSUPP;
> >
> > +	if (p->post_addr) {
> > +		u64 _val =3D ioeventfd_get_val(val, len, unsupported_len);
> > +		int r;
> > +
> > +		switch (len) {
> > +		case 1:
> > +			r =3D put_user(_val, (u8 __user *)p->post_addr);
> > +			break;
> > +		case 2:
> > +			r =3D put_user(_val, (u16 __user *)p->post_addr);
> > +			break;
> > +		case 4:
> > +			r =3D put_user(_val, (u32 __user *)p->post_addr);
> > +			break;
> > +		case 8:
> > +			r =3D put_user(_val, (u64 __user *)p->post_addr);
> > +			break;
> > +		default:
> > +			WARN_ON_ONCE(1);
> > +			r =3D 0;
> > +			break;
>=20
> goto unsupported_len instead of handling an unsupported length
> differently here?

Ack.
