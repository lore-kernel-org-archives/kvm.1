Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.155.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793123566;
	b=MlTeM4hX7wp/35GvGiuWk9aMo3RLjRhUOEMh3Vmdna9WycgGla/KwTDr2L5QAzVO2dGO
	 UjhYfsT3SYExaKPVlI0sZHJPSxBrRY0WE9ZJTeeAd7X15kUtnByC/d2bW8nIhT3UQvpUd
	 /cyq5yBpTKdndFUCq4VJLvD/aSs9nXvj4TvcwNBlZbH1QoEGnuva5xlMyTjjf7SyBAA5D
	 zQtfWMJuswyvctdT0JltrAMb4jzNsO5mu1JF/nmSaJm0os/eOgQkhwMAneUp9Eh47D6Fy
	 Eh7d8HLmbSU89N7F52/CkfMLVRplg4pTYDg1tr9HihtnOrwsj8eMqtCfdD9mPeR3C3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123566;
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
	bh=57WHa0ib4oPuR0VTx3eF3yar58eQYITsARFi6rH4R2Y=;
	b=dULDUhk0BDHXfmFD8+v57O7y1dak1S+Iesp2dYP8OtVo8dqLu0Wb7DROfshD9Jrbku6Q
	 BDVhRCskRoAQOrH6om2butUAlx7xu0IBsQ7Ct9ifE4XaZFzF0aQaRk0Bk9yiAVhCJY0x7
	 slH3XJfc4iUcu+uzTbqUEde8q9+ywbD2wJ5E38q/GFC0ExhOqXhpjv1yTpRlRCpegRbx9
	 7A5Dpn3RDOfXaR6nv6m/PpV7VSn0YYlCyNtypq2NBTrKeFTKdDdwbzXfWPTWb82mAhC9e
	 HYx9DS2ulmCb4fXhgTiRSh3VKM+8qE0NNWHnM4xxJSgq6Gxub4HPQMtHQWvpTtDL59Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nutanix.com;
	spf=pass smtp.mailfrom=nutanix.com;
	dkim=pass header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=ceuDqYYU;
	dkim=pass header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=zI4n62nm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.155.12
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F130606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 17:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F130606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=ceuDqYYU;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=zI4n62nm
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RGxw0B3900788;
	Tue, 27 Oct 2026 10:52:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=57WHa0ib4oPuR0VTx3eF3yar58eQYITsARFi6rH4R
	2Y=; b=ceuDqYYUpKXs3hFSdOX3BwFJ+U6DSvHjEo5g/ccdOL3bY98SKaCtPhqFO
	KK8vMVoTK6r4ADcgzOU2PuUMTySOFxQhDEP1zCwmjZFY9L9y6H0QdG9ET0ANfH3s
	UvDmYHdzdSMXP1wzrWV8lbp12qgSRPvrHy0eHvzIphQHZuw7fmXTDoDZs1Sz3/tK
	UjvXdWKD/3jWK1jDQZbIS7ums1e13Y3uC47PkG4WF7febQPhMms3NXJc8gQQbs58
	oPR6SU7yndYOf1E8K48PPVD7HhPnPHXLIo5aJ/AztlXuqbs2IFQu5HjYi1JnvSkL
	C80Cc3H2vIWWIPKqJ49GGt8OhI1uQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11020083.outbound.protection.outlook.com [52.101.201.83])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hj45qvmvd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 10:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mG6BJc/OQRraT1LGkdBd/Cnu/ZunAU2W8XSrguj4r4kfInfQm0PhCduHll2UHRh01RbTWpxaWeEFMvSjlJEiQmyKG0SJlidqpdG5EHyaXaRcohr0nD5jyLkklnuZX3lJjKOYLtF2D2GGsmOCZdFhTlylGMqr4/aKqHbhEXRi7N8X+HGl6o6nSKa8dPAwHt8CF0QcMB9oYtRd/amEftBHZeFxLKgeUbw6bwnIK85e8WKhKbmiDdjbv0JuucEKxevkawZtB/bHv0VPHGBRWh17d4T/oNZbMoL0GLBCpuyurHsdhAHhwmvJ9Y/SIcc7BJhv4mqGDUxE/tEP8FP+J36S9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57WHa0ib4oPuR0VTx3eF3yar58eQYITsARFi6rH4R2Y=;
 b=WuSi0ZLHhOwsoPvxrZfKE7tKUspiaiKUxOzVKIoQ3ChU6jCV/WxQ5TCmRH4iOwcY2e72XdwQhsXusd3rXmh4vWlYIP9esPQXyUprYd1rx3GIS/kf9CX6jIsnCvye6Nx1iogAkOUGqlWr08BA+aiWJS5sHAVQrXqiSiJVcCyKV30Q2ksQMrjqGJxFmbwD+YBHbzx6RHLKp/x5JqcHMxGxs4NshgacpSiP++lFzRYMnGHibf0a5tmzJWYEy269C59LV0UYGVhNLnTkAt+I7CCRUOGN47tCW6x1IuI2dixn/tA2ngSO/cJAljegqBidclZWrOjdTLZVz8/Yd2KmOSxXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57WHa0ib4oPuR0VTx3eF3yar58eQYITsARFi6rH4R2Y=;
 b=zI4n62nmCas2up0BOfCAWWU3wwL7Uxuf21toWoUd8GD3Sl7cmB8dCX3vTM+s3kJo/o6a5EQq9RTct/pm6XXHgXJxz+EBvWJ5D8T45PDxEs5IPnOXDmyNp+8e0AYjcjdA7OdUpKjUzx6qsn9ZfB3sCaZZb32ZgOWLcLQS+jk1v4YMcRRO1aXhoCvZmZR+T3mq00fOMzFA0/q4p5jzVT8BgMJaL3LzZvK+OwgVnhNKDJMNKcM0rZQUJgg/zB5amkPbxuXpUJw2Os1J+odZp39n7gDWfb0zdhXf7l9asNKw5MRb0ap7ipvlYp1iLGjStXFOJTIuXGGwPLaKXX+6J8c/yA==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by CO1PR02MB8666.namprd02.prod.outlook.com (2603:10b6:303:15d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 17:50:25 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 17:50:25 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Sean Christopherson <seanjc@google.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
        John Levon
	<john.levon@nutanix.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "stefanha@redhat.com" <stefanha@redhat.com>,
        David Woodhouse
	<dwmw2@infradead.org>,
        Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: RE: [PATCH] KVM: optionally post write on ioeventfd write
Thread-Topic: [PATCH] KVM: optionally post write on ioeventfd write
Thread-Index: AQHdSrRLXtWCtr4qFUWEUj3nkP4ecLcR4W6Q
Date: Tue, 27 Oct 2026 17:50:25 +0000
Message-ID:
 <IA0PR02MB94625B97B9A1EBC2B1630F158B602@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
 <arK05GrLtiBvbfmm@google.com>
In-Reply-To: <arK05GrLtiBvbfmm@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|CO1PR02MB8666:EE_
x-ms-office365-filtering-correlation-id: bdb0113a-9d66-4e9f-65cf-08df3452c803
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|261026121527099003|38070700021|4143699003|56012099006|261021121427099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003|6133799003|261026140227099003;
x-microsoft-antispam-message-info:
 RMFPKLvNd+Bq1cpAsRzCJTpvHHvPe44ClfqllJLVGjRGeTpUPbAve50OxLTaHe55Mqqpb2g8kdRlnInfhb1gQzakUKVDhErP7m66ghsiZdt/zvsLA2U+vCHJQPciDmTDbgoG23kg+haqtZVMOKipZEFByBm6ygVboRM9KWQlT3Br7NyFLY7Mxglq1N0eOmosxKSPVLHDNbMeaNH86FMNJMfMvdDuRJWmzi8vfhofUoDHZNVP3N8MLMXCu+Tw9n4E0E6Z+A50QtAmjr4x42O4A/nOngiP55Y2/qzqAbMHCdkrH0L1FZUs2gnO85FUuDNHn9TNWo8KG//l9virwXQDRWXTnGTcOx5QhdGYlb2IdWMRPtSKmiykqncteMDtTwq1H86xC/gUarjNv7fbx7h2wqKePNmcJ/GwULYLA7izNkit4wnyXUFjYqhJ/n1UjDCdMRpodMNFTZq7QziHnAkyN2Cr8T5bwJnHGm8L3LYyawqNJNtCF9NbRu7qeOKTCK+lcn9rlLov3REOsjfeVDfGYJByNVj1Jv5Ga/SMqnTu+8TUQ/Q4w2tScZYxJeDQUDOC5EIpw/oe0E2SUHZKgVlfJqbE4kU5Frzw3JiDTyRFmWH+a6UwKwVtJNGMkOcmIjPOPVosA7GvA7lwU6LB6IAPLkyveXoEHIM1ovzNKjguFW/egPBCsTh34/dlEJANRSrfnldyPJv11bg0hR+gT9o4SL3OhREOeo2ff0lIr/G2u5k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR02MB9462.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261026121527099003)(38070700021)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(261026140227099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHhCRm5BVDVyWlNrSkJyMXhFTEJmZXRNTE1HbjN5KzBYRythY1dvWnBHVWU4?=
 =?utf-8?B?dW9QN2hHS2dsNGs2MVVqWEhMSGVaUE5BYmM5SithYlVaVS9OeUZLTWdIV1pQ?=
 =?utf-8?B?eEdBa1NNU01nVUNFUUQvdXhjWGF2M2pKcWgzMldVaGo0c3h5WXNMcHFFK0NR?=
 =?utf-8?B?K3B6L2syRFNLanA0Qkk4SytvYnZlaDBCS1pONWdKUUhHRjRFMTlzVjhDaWRK?=
 =?utf-8?B?WDIvMnBrVVdoVFBJb3U3aFI4ZWVCckNibHlsZ2RSTUQzd0VwUkszSXJGYkJk?=
 =?utf-8?B?dFo0K01BS2N6dzZBcTRaZm1NUWlJUFNGZUlXSmtKMFNWakREMGtqc0N6N3hz?=
 =?utf-8?B?VVNESFBaaktLRlV6MTV2UTI1bjAyenl3YkJFeFJoTzRTWU9BdmlmTkEySi8x?=
 =?utf-8?B?M3UvdDVxNjZqY21DNWdSbjhqWmFEZ3dWN2xFbGRPWHAxS1EvRHBXMVlxNWpM?=
 =?utf-8?B?VjFXdnAxM1Rrbm5tNW5aUVR5S2hzcjNzN3ZLQUltL1QxVnBCUnd4OVhrbWhF?=
 =?utf-8?B?L1pLalE0NlNyM3VrRkxoMmRYVjh3ZEcrT2kzMDY4V05USnM2VDlVU291MmpT?=
 =?utf-8?B?M2J5MUFwSlliTjNJS0h6M2lJT1QwWVNTaXF6V0F6Z3hzVmVubHpzWjdqU0VN?=
 =?utf-8?B?QVlsa0xna1cwT2NWU2pEbFJ5OUUremhpa3N0V3ZBdG5Tb29vWmhGT3oxL25k?=
 =?utf-8?B?S0ZEdmZOeXM4OVdrSTJsamVRdnBoSTRtSFhZaUtYZnhBUEJLa3B3TXBDcWp4?=
 =?utf-8?B?OERvT3lKaFhqZUwrVnRNdWZxcnZrK1BlQ1ovaUNNcmRrZHFxMEhaYWJSRmp4?=
 =?utf-8?B?TTE2c2d2MlV5MDN3S0dmY2l4bGZGcG9sT3BUUEFIQVpaSyswK1BiMTBUd1dQ?=
 =?utf-8?B?TVFXUlFmcHpxRmxEb2hxUkJVditOSDRsYjZRNzkwV2d2cno4YjhERXlpK2sz?=
 =?utf-8?B?bk5VVVhSREtDSVZoUUsza3lIaHN2ZGJndm9kV3dBcFBJdXQ2VXFObC9ZaWlz?=
 =?utf-8?B?b1QxTWVNaHQrdE5SMHZ0allHR1RKYVFPeHAxN2pmQUtMaTVmZGF0QlM3clVJ?=
 =?utf-8?B?WDZQWno5eWtJMndtM1NzUE81eVYwcjdhM0VVTEU2cnBPTURGWURXTHBoalQw?=
 =?utf-8?B?dldrcTlnWjhZbFpVOVhQZkdLOEMvcXRpaWp0dXA5b2NhNk9JVEdVbnV5VkJL?=
 =?utf-8?B?SnI2emtTc0hrdy81MEVoMiszZlZRUi9tTEpTVVpNZVB0OGc2UHZ0eDdZMmJ2?=
 =?utf-8?B?U3N0SUhISlEwNlJDaG8xWVZyL3BJZFFjVk9OdjQzK283VzQ3ejlxbHVtUURy?=
 =?utf-8?B?ajR2RjlYdW9tc1V1TWZSVTV0emh1RGxmZGNZQitVbFd3R0FhZUpWbU9XTEx3?=
 =?utf-8?B?R1BFdTZoczZrby96M0EybjBFdXJsSXAweWhEaTRPNkp1bGtPS3BqeXNuZllP?=
 =?utf-8?B?OUd6dDlVVFpqMklBSFd3TGJpVkJGUE9mS1JUTFZPVE5saW1WRk84M0ZhOHFr?=
 =?utf-8?B?MG00Qm5yZ1JjdW5HaUZhMXVHYVhLK3E1dEhySlJEK0JYNWZlckhLeXlDOUkr?=
 =?utf-8?B?dG9uaklZMDBINysrcFd0YW1Ma3BaY2x5RmpGcXhuNTE5NkF0czZDUWc3a2xm?=
 =?utf-8?B?L2d6K2FTMHU3eXp1dE1vM0VBanFabjBQMlQ5ZUVNZUlJSUFtWGViazExblNs?=
 =?utf-8?B?cFExU0p0VHJsTFk2NC9sdHRwR3lQajNQamJBODdWNlNPRFlNMWhlbGtoN0VI?=
 =?utf-8?B?ODYxY3RtU1g5ekl1N0xHODVFSlpaRnZPK3RLN3E1ckMwVUlCSkVocXlmWGZr?=
 =?utf-8?B?NHY1YTN2Z2wxQkhHVWVZck1TZC9LTExkc3dNYlorMHNHYWpuWHBIa0ZJcjBI?=
 =?utf-8?B?NmJUWklUK0UzNmJtbVVpNEIwLytjVkhmUVNkaGVEWTc0Wi9uU1ZhbUVoRG1I?=
 =?utf-8?B?WGNkbDVXbHUrekVQaFhvMkhvaUExNmVkMytXK1dNQlBPaUZwSFByN3lQdjVi?=
 =?utf-8?B?SHlZY2x4OEUwT1orS1JPREFGcXdlelhNRDJXWWp0ZWtjNFZScWVtbVdwcDRP?=
 =?utf-8?B?NkRra3h0ZnI4NjVKWDZXQjZtbTBINEhGUjF2WDFmYWhoaEYzMy9McStQOGVO?=
 =?utf-8?B?aWwyYzF3RWZ0b2RGVmhWWW1raDhUZm9tY2NkVkJGL0M3eThyaTJobDUrbThy?=
 =?utf-8?B?UmFTZEsvblZINUVJSzhmMHZhVkNLTWdHYlN6aysyTlpDdFg3ZFFBUk9QcENX?=
 =?utf-8?B?aDIvV2Z6U3dxOS9iMU43WXZaYjhNU3lmUkZSanZDcWRoL0xpMlJEWUZqU2RW?=
 =?utf-8?B?Q1FVSEdrZjdIRVE2SUVQVGhSb085MkZvYWtpTXdJU2xJWE5hUGlpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
	ZPRIb3acmoqKlQtj0dSKxVXhtlqsunVminmvNnKz6cDPiBowyKmEI5GF6ysAibYT/I6JrDt08iUox/zeH5/8QoTvaZ2aaB4ggzGRxGIP9et0cjpVi8e7JAljW1nfx6glYsyaBFAsRcBLt52mjeeHkP/yPTy/bykYxVCCtBT8FI9Jp93wOUcEbblYJHFPnYrBQcs7vgdMZXTDSkVq70d0WhFpm1ZFoSwqpmflNzyWBlpDViJt8ioirvVDVomECQcmcA6zIZTeVkalj5HQIdk/lMTqdRSNZKojEMAdLzwdWAj3dK5nAgcjNS/79ARxxm07mg/yE/AuI3GEd4ySHJ64DA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb0113a-9d66-4e9f-65cf-08df3452c803
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 17:50:25.7275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZHU3XL/wVJQz87YdqtE2v1nHXm21vAOCqOzfw1pCtUCRTz1nelMkvmW0DYiqfGcc9f06qhUsIe2NjZFOIs7mk9tdomjHzk7wPaGoT4SrFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8666
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfXwgTDseJwRtLx
 km9xls+CZzq2Ijb1FpCvh6dZYlsEw2EJxXi5rNkcGJkao3MSjr9WJWMc7riSnNK6dykkzucO46X
 JH8T5IAcgET0ylxPQ6WhuSowZszfvSP9pM83RyXRfavXiTpVCirL2oYFGtbm2F3lyWRH14T2+Tq
 NH7q1qblFE3C9IDFNcDGKvC1+7+h/nuCBnp6Gitc/H0Wdz58hrDGr1TC8qtT85jlvXTa8VfBzr9
 GnuGfmlg1jvKYlstx6mqgveFYpDBFzZzpoEX6XRQIhWYCHdsHzgkLUw9YOOia7R+03Po5SGOLsp
 mZklMyb0aBP5X9RBXrHMs5Mw1ZqVYRAlTRFE6sTg279r7rEvt364+uCJOWEULFRbgF6OjvOpsSD
 IWlKX8qjpcB9jiqOqWI83HDxUywscWLqvZebh00SwRzpT5tEbiyMRfMX5lj2Bq0Sh1GGt6V3qon
 +U42tzTwtcCptKA9O2Q==
X-Authority-Analysis: v=2.4 cv=KJrPn1Fo c=1 sm=1 tr=0 ts=6ae0e4e4 cx=c_pps
 a=ZKh0PibMILooJbODhNUGZg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=1XWaLZrsAAAA:8
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=C3mYx1tBoyJHmkH5EtYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MSBTYWx0ZWRfX6DydHqEpQj8q
 fgZkQs8ppqkusCXx9PqHFp779PesFAzclbsISeci9K+qhtkWDLbYLTZX0ED0vgYj0TN8Wbsdx/o
 KD0mN8ZIvAkZqcECeP2M2RFi1WRX9EY=
X-Proofpoint-GUID: _TcogW6o7ZW-YsHJiYxpZ4sCk9t6DZQJ
X-Proofpoint-ORIG-GUID: _TcogW6o7ZW-YsHJiYxpZ4sCk9t6DZQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWFuIENocmlzdG9waGVyc29u
IDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gU2VudDogMjIgU2VwdGVtYmVyIDIwMjYgMTg6MDQNCj4g
VG86IFRoYW5vcyBNYWthdG9zIDx0aGFub3MubWFrYXRvc0BudXRhbml4LmNvbT4NCj4gQ2M6IHBi
b256aW5pQHJlZGhhdC5jb207IEpvaG4gTGV2b24gPGpvaG4ubGV2b25AbnV0YW5peC5jb20+Ow0K
PiBrdm1Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEtWTTogb3B0aW9u
YWxseSBwb3N0IHdyaXRlIG9uIGlvZXZlbnRmZCB3cml0ZQ0KPiANCj4gIS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+
ICAgQ0FVVElPTjogRXh0ZXJuYWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24g
RnJpLCBNYXIgMDYsIDIwMjYsIFRoYW5vcyBNYWthdG9zIHdyb3RlOg0KPiA+IEBAIC02NTYsNyAr
NjU4LDggQEAgc3RydWN0IGt2bV9pb2V2ZW50ZmQgew0KPiA+ICAJX191MzIgbGVuOyAgICAgICAg
IC8qIDEsIDIsIDQsIG9yIDggYnl0ZXM7IG9yIDAgdG8gaWdub3JlIGxlbmd0aA0KPiAqLw0KPiA+
ICAJX19zMzIgZmQ7DQo+ID4gIAlfX3UzMiBmbGFnczsNCj4gPiAtCV9fdTggIHBhZFszNl07DQo+
ID4gKwlfX2FsaWduZWRfdTY0IHBvc3RfYWRkcjsgLyogYWRkcmVzcyB0byB3cml0ZSB0byBpZiBQ
T1NUX1dSSVRFIGlzDQo+IHNldCAqLw0KPiA+ICsJX191OCAgcGFkWzI0XTsNCj4gPiAgfTsNCj4g
DQo+IEkgd291bGQgcHJlZmVyIHRvIGhhdmUgZXhwbGljaXQgcGFkZGluZzoNCj4gDQo+ICAgc3Ry
dWN0IGt2bV9pb2V2ZW50ZmQgew0KPiAJX191NjQgZGF0YW1hdGNoOw0KPiAJX191NjQgYWRkcjsg
ICAgICAgIC8qIGxlZ2FsIHBpby9tbWlvIGFkZHJlc3MgKi8NCj4gCV9fdTMyIGxlbjsgICAgICAg
ICAvKiAxLCAyLCA0LCBvciA4IGJ5dGVzOyBvciAwIHRvIGlnbm9yZSBsZW5ndGgNCj4gKi8NCj4g
CV9fczMyIGZkOw0KPiAJX191MzIgZmxhZ3M7DQo+IAlfX3UzMiBwYWQwOw0KPiAJX191NjQgcG9z
dF9hZGRyOyAgIC8qIGFkZHJlc3MgdG8gd3JpdGUgdG8gaWYgUE9TVF9XUklURSBpcyBzZXQgKi8N
Cj4gCV9fdTggIHBhZFsyNF07DQo+ICAgfTsNCj4gDQo+IHRoYXQgd2F5IGl0J3MgbW9yZSBvYnZp
b3VzIHRoZXJlJ3MgYSBob2xlIHdlIGNhbiB1c2UgaW4gdGhlIGZ1dHVyZS4NCg0KQWNrLg0KDQo+
IA0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMva3ZtL01ha2Vm
aWxlLmt2bQ0KPiBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2t2bS9NYWtlZmlsZS5rdm0NCj4g
PiBpbmRleCBmZGVjOTBlODU0NjcuLjdhYjQ3MDk4MWMzMSAxMDA2NDQNCj4gPiAtLS0gYS90b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9rdm0vTWFrZWZpbGUua3ZtDQo+ID4gKysrIGIvdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMva3ZtL01ha2VmaWxlLmt2bQ0KPiA+IEBAIC02NCw2ICs2NCw3IEBAIFRF
U1RfR0VOX1BST0dTX0NPTU1PTiArPSBrdm1fYmluYXJ5X3N0YXRzX3Rlc3QNCj4gPiAgVEVTVF9H
RU5fUFJPR1NfQ09NTU9OICs9IGt2bV9jcmVhdGVfbWF4X3ZjcHVzDQo+ID4gIFRFU1RfR0VOX1BS
T0dTX0NPTU1PTiArPSBrdm1fcGFnZV90YWJsZV90ZXN0DQo+ID4gIFRFU1RfR0VOX1BST0dTX0NP
TU1PTiArPSBzZXRfbWVtb3J5X3JlZ2lvbl90ZXN0DQo+ID4gK1RFU1RfR0VOX1BST0dTX0NPTU1P
TiArPSBpb2V2ZW50ZmRfdGVzdA0KPiANCj4gUGxlYXNlIG5hbWUgdGhpcyBpb2V2ZW50ZmRfcG9z
dGVkX3dyaXRlX3Rlc3QsIGFzIGl0IGlzbid0IGEgZ2VuZXJpYw0KPiBpb2V2ZW50ZmQNCj4gdGVz
dC4gIEFuZCBtYWludGFpbiB0aGUgYWxwaGFiZXRpY2FsIHNvcnQuDQoNCkFjay4NCg0KPiANCj4g
RG9lcyB0aGlzIGFjdHVhbGx5IHdvcmsgb24gczM5MD8gIFdoaWNoIGRvZXNuJ3QgaGF2ZSBNTUlP
Li4uDQoNCkkgaGF2ZW4ndCB0ZXN0ZWQgb24gYW55dGhpbmcgZWxzZSBvdGhlciB0aGFuIHg4Niwg
bW92aW5nIHRvIHg4Ni1zcGVjaWZpYyB0ZXN0cy4NCg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvdmly
dC9rdm0vZXZlbnRmZC5jIGIvdmlydC9rdm0vZXZlbnRmZC5jDQo+ID4gaW5kZXggMGU4YjhhMmM1
Yjc5Li4yMmJjNDlhNDE1MDMgMTAwNjQ0DQo+ID4gLS0tIGEvdmlydC9rdm0vZXZlbnRmZC5jDQo+
ID4gKysrIGIvdmlydC9rdm0vZXZlbnRmZC5jDQo+ID4gQEAgLTc0MSw2ICs3NDEsNyBAQCBzdHJ1
Y3QgX2lvZXZlbnRmZCB7DQo+ID4gIAlzdHJ1Y3Qga3ZtX2lvX2RldmljZSBkZXY7DQo+ID4gIAl1
OCAgICAgICAgICAgICAgICAgICBidXNfaWR4Ow0KPiA+ICAJYm9vbCAgICAgICAgICAgICAgICAg
d2lsZGNhcmQ7DQo+ID4gKwl2b2lkICAgICAgICAgX191c2VyICpwb3N0X2FkZHI7DQo+ID4gIH07
DQo+ID4NCj4gPiAgc3RhdGljIGlubGluZSBzdHJ1Y3QgX2lvZXZlbnRmZCAqDQo+ID4gQEAgLTgx
Miw2ICs4MTMsOSBAQCBpb2V2ZW50ZmRfd3JpdGUoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBzdHJ1
Y3QNCj4ga3ZtX2lvX2RldmljZSAqdGhpcywgZ3BhX3QgYWRkciwNCj4gPiAgCWlmICghaW9ldmVu
dGZkX2luX3JhbmdlKHAsIGFkZHIsIGxlbiwgdmFsKSkNCj4gPiAgCQlyZXR1cm4gLUVPUE5PVFNV
UFA7DQo+ID4NCj4gPiArCWlmIChwLT5wb3N0X2FkZHIgJiYgbGVuID4gMCAmJiBfX2NvcHlfdG9f
dXNlcihwLT5wb3N0X2FkZHIsIHZhbCwNCj4gbGVuKSkNCj4gPiArCQlyZXR1cm4gLUVGQVVMVDsN
Cj4gPiArDQo+ID4gIAlldmVudGZkX3NpZ25hbChwLT5ldmVudGZkKTsNCj4gPiAgCXJldHVybiAw
Ow0KPiA+ICB9DQo+ID4gQEAgLTg2Niw2ICs4NzAsNyBAQCBzdGF0aWMgaW50IGt2bV9hc3NpZ25f
aW9ldmVudGZkX2lkeChzdHJ1Y3Qga3ZtDQo+ICprdm0sDQo+ID4gIHsNCj4gPg0KPiA+ICAJc3Ry
dWN0IGV2ZW50ZmRfY3R4ICpldmVudGZkOw0KPiA+ICsJdm9pZCBfX3VzZXIgKnBvc3RfYWRkcjsN
Cj4gPiAgCXN0cnVjdCBfaW9ldmVudGZkICpwOw0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+IEBA
IC04NzMsNiArODc4LDE2IEBAIHN0YXRpYyBpbnQga3ZtX2Fzc2lnbl9pb2V2ZW50ZmRfaWR4KHN0
cnVjdCBrdm0NCj4gKmt2bSwNCj4gPiAgCWlmIChJU19FUlIoZXZlbnRmZCkpDQo+ID4gIAkJcmV0
dXJuIFBUUl9FUlIoZXZlbnRmZCk7DQo+ID4NCj4gPiArCXBvc3RfYWRkciA9IHU2NF90b191c2Vy
X3B0cihhcmdzLT5wb3N0X2FkZHIpOw0KPiA+ICsJaWYgKChhcmdzLT5mbGFncyAmIEtWTV9JT0VW
RU5URkRfRkxBR19QT1NUX1dSSVRFKSAmJg0KPiA+ICsJICAgICghYXJncy0+bGVuIHx8ICFwb3N0
X2FkZHIgfHwNCj4gPiArCSAgICAgYXJncy0+cG9zdF9hZGRyICE9IHVudGFnZ2VkX2FkZHIoYXJn
cy0+cG9zdF9hZGRyKSB8fA0KPiA+ICsJICAgICAhYWNjZXNzX29rKHBvc3RfYWRkciwgYXJncy0+
bGVuKSkpIHsNCj4gPiArCQkvKiBJbiBLVk3igJlzIEFCSSwgcG9zdF9hZGRyIG11c3QgYmUgbm9u
4oCRTlVMTC4gKi8NCj4gDQo+IE1heWJlIGVsYWJvcmF0ZSBqdXN0IGEgYml0PyAgQW5kIEkgdm90
ZSB0byBkcm9wIHRoZSBsb2NhbCAicG9zdF9hZGRyIiwNCj4gZXZlbiB0aG91Z2gNCj4gaXQncyBt
b3JlICJ3b3JrIiwgYmVjYXVzZSBpdCdzIHN1cGVyIGVhc3kgdG8gb3Zlcmxvb2sgdGhhdCBLVk0g
Km11c3QqDQo+IGRvIHRoZSBjYXN0DQo+IGJlZm9yZSBjaGVja2luZyBmb3IgYSBOVUxMIHBvaW50
ZXIuDQo+IA0KPiBFLmcuDQo+IA0KPiAJLyoNCj4gCSAqIERpc2FsbG93IHBvc3RpbmcgdG8gdmly
dHVhbCBhZGRyZXNzIDAgc28gdGhhdCBLVk0gY2FuIHRyZWF0DQo+IAkgKiBhIE5VTEwgdXNlciBw
b2ludGVyIGFzICJubyBwb3N0ZWQgd3JpdGUiLg0KPiAJICovDQo+IAlpZiAoKGFyZ3MtPmZsYWdz
ICYgS1ZNX0lPRVZFTlRGRF9GTEFHX1BPU1RfV1JJVEUpICYmDQo+IAkgICAgKCFhcmdzLT5sZW4g
fHwgIXU2NF90b191c2VyX3B0cihhcmdzLT5wb3N0X2FkZHIpIHx8DQo+IAkgICAgIGFyZ3MtPnBv
c3RfYWRkciAhPSB1bnRhZ2dlZF9hZGRyKGFyZ3MtPnBvc3RfYWRkcikgfHwNCj4gCSAgICAgIWFj
Y2Vzc19vayh1NjRfdG9fdXNlcl9wdHIoYXJncy0+cG9zdF9hZGRyKSwgYXJncy0+bGVuKSkpIHsN
Cj4gCQlyZXQgPSAtRUlOVkFMOw0KPiAJCWdvdG8gZmFpbDsNCj4gCX0NCg0KQWNrLg0KDQo=
