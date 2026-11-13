Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588397;
	b=AH4fIyWvF3h1iRdEUEc6Xwb1MRQGTkomi5P9xiYKJ07TCGcAVLKM5kOKYNL2cLeXW7U0
	 2r+g9patqskYDhs61j9nbJEkiYgDzuFZGPuLihxqMEymAtJnaY80Fwq+1pspbcKWcl8eO
	 CgCAqNctx9DxyfH3hZE4UB06GQk4MKMdNRnvdex6E1RlVNCtpButRJ/IkxuZq/R9Hy+CQ
	 hGJrEiNaqUMBTwNyRmW9exmMHLDwADW/AgWjeGPQHAssmW1litKslAjvJRtM5om6+T+Iu
	 v8A/wKvWSW7Ouus7j6MPIrKqHGCaBExZNbvj29lmwxjxbbHAd4TGQtdsBKcLrWPt3Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588397;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-traffictypediagnostic:x-ms-publictraffictype:
	 client-request-id:request-id:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NOJfqKH48WO1zsyZPcEgWqtXpkPRMWr4UK5xL24YC50=;
	b=0B49gXzOsHRqc0p6mWIxQ3IS1wTzAhgDnOngDhnNCK/4MJqKb/dTrOP+08lBbDMf6QjH
	 ikdtu1paziviXowrULqqdm27s0sXBK6HWZOatl7GBwugvYcri6dFyAAm2TT/O701yTxcJ
	 8gtQXhZezWwSSfv9b4CIt7kAVJrrhgdsl9D3+qMwHFf8KbaT1Xvkm4yaW8Q98sEzZJWyX
	 v7fqwT3n9NRXIw5r2xGDIeJjFL9LAQ4TNvF24Uc0G4OIW3zT7C9Xe+VHs8HWlCeRI9RI5
	 sOJtIcn+BvRfUxfr5cp5Icy3c/U6AlBcR6s9++X0c1ilmCJjW6eWA9sDqGbxVwa+5Ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microsoft.com;
	spf=pass smtp.mailfrom=microsoft.com;
	dkim=pass header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b="cPjHFc/t";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.112
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020112.outbound.protection.outlook.com [52.101.85.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7998606F5DB;
	Fri, 13 Nov 2026 16:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7998606F5DB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=cPjHFc/t
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygAlKxioVgSmQlmmk7CMRQUM+jT6KqsfQpNzTKNmeRezYxzL32hGk7qLbJH7Ko64leKCfq1KQbs++o6heO3RJGBbrY+JzjYaUsm1kO0jmciAzXSM6mERxd48yBlJxhZuehVSisRDZJkXLeiJjR9AmBdaTFFzjAqmeY+IqQw+lIyaQyUFYpjnlQztDanoddzYFkRrNZn29R2M5N5/QirgRuquZaxPldOM3F9JX7GOA/lqgYOoFbTVhon0qcF0tGo4sSfLpfCzLmct6+9mz/k/ssaNaQQiMH0dPunnEk8k5mUEldNLazcnZO9W0yJivggGOMhn1eLlO+FgMTdEy3vzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOJfqKH48WO1zsyZPcEgWqtXpkPRMWr4UK5xL24YC50=;
 b=ESfaadO75x0MBR4A4sLX3kAZ9XhUEbE3S4q4IEJNfSvxYEj1tt/nXIDoirJhNdSRGffgp3l6mwRhJc6sCETBRWQe+MQl/r3yyGZ3Ex8ui3AtxNm9zOSaTLBArfsXseauTNJ39kSlS69XePb8rKtJvmvhVtARzcLMJ827snkTpG5aETBI+v7LIa5EOKdzUJgx0c7dF73wXcRNj5hQCgQCVMhVjJF3RG2pPovVqwZA7Zs3z3cgI6NtQkGeezVQt6iqWJfBVs5OoFIs5SoT8hiP9CoLh+hNg8yNnlerpP9w48w/XbrcNMutGe0Fdw1NTz4eQaaRXq8XzLM2OP7t3BeQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOJfqKH48WO1zsyZPcEgWqtXpkPRMWr4UK5xL24YC50=;
 b=cPjHFc/tJtGC91QI2RsUkP1oBJ+OmhWAgej4aTlpAHtB0rQkYq888We/rSw+1887RUEPoa2LXsHOOnpITPSgazIT6PKKP3aHo1tLbuLZ2LPB9n6r8c7I1TMtcJI31NicbbWLfQvfnL++PZ5Hz/1AmmWxlzvjEQ3oyY/StqTbGSc=
Received: from PH0PR21MB6375.namprd21.prod.outlook.com (2603:10b6:510:378::24)
 by PH0PR21MB6829.namprd21.prod.outlook.com with HTTP via P2P; Fri, 13 Nov
 2026 16:36:02 +0000
Received: from PH0PR21MB6375.namprd21.prod.outlook.com
 ([fe80::90f9:9846:b074:bf3a]) by PH0PR21MB6375.namprd21.prod.outlook.com
 ([fe80::90f9:9846:b074:bf3a%4]) with mapi id 15.21.0639.000; Fri, 13 Nov 2026
 16:36:02 +0000
From: Chris Oo <cho@microsoft.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?Carlos_L=F3pez?= <clopez@suse.de>, Stefano Garzarella
	<sgarzare@redhat.com>
Subject: Re: [EXTERNAL] [PATCH] KVM: SVM: Sync CR8 to the local APIC after
 marking the VMCB clean
Thread-Topic: [EXTERNAL] [PATCH] KVM: SVM: Sync CR8 to the local APIC after
 marking the VMCB clean
Thread-Index: AQHdc4utbxbAl4ae2UOKZ2U7xE+gdLcsMS/3
Date: Fri, 13 Nov 2026 16:36:02 +0000
Message-ID:
 <PH0PR21MB6375986CC10D4E865D568E2EA57F2@PH0PR21MB6375.namprd21.prod.outlook.com>
References: <20261113162556.461390-1-seanjc@google.com>
In-Reply-To: <20261113162556.461390-1-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-11-13T16:36:02.335Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-traffictypediagnostic: PH0PR21MB6375:EE_|PH0PR21MB6829:EE_
x-ms-publictraffictype: Email
client-request-id: 6dddcbaf-0640-4e0f-81af-a25d6db9c6bc
request-id: 62e7570d-18d6-483e-f4a4-08df41a434ec
x-ms-office365-filtering-correlation-id: 62e7570d-18d6-483e-f4a4-08df41a434ec
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|7146999003|10067099003|38070700021|11063799006|56012099006|261021123027099003|261102123227099003|261022075727099003|261028144727099003|261026140227099003|261021121427099003|261009223027099003|261022105027099003|261026121527099003;
x-microsoft-antispam-message-info:
 csZvOo+FHWVMg/MP6aQVrEdvBvIcRQPFwEeiStDUKOhlMXMUnENpvWlCVdwLPLkgjbMPM3R6+Avq93pqCexksMrSxX6QCJhmBBS3yuzvtMCLDZHwYWvjjfm/+94ujMxHfFHyeF4uZhv7TQXPLhjrOlNHcU1d+OJoeZlIFYyLOpIRetA2J2BXuy0QVJ0V6a8h63qKBPHRW1dGhIueoS/hoJoWBTnhnZ/mMiGc0zJPQ6Vf0zPuLrokFHBLNtJnvrFZhjTLpBDOk5H3+FqpDWnlhA74xoWBIZ3R70PrHzroYXpLeGlv2ZfTmGqLMorQp16v7EsLH8Zw5BDDGgqdSACt24FKg0fkhm53qU9WqpJPQbGRfacT9hd3YMoHs/TwGyNBi7+XUvEeEN9Hq43Xd6l9iyYnisIcsqQJEBDrMJ/U7PIqC3nfq+lcBi45oUh00Rfj2oFytsACm3GthX4fJiiIClDINqq9VIjEr/kEqvANsG+r6uwDeS+4zOKc73hBcTj1OhYNd4JItE/DebUxvTkO11zZ3btWWtIjkta1CBmJ6dQMQiEmG6tyb9GpidvTu//ksnQvfippjIhlZWETIwNu/O0VjZTUdTf3zTzqdP3vpdhygpz3dcarhPaMgYFctYamjlXL98bAhBK/EQu851D3JZ4Hv/P9AHZEamyRRnHtouN07M7bN0FSgG6AsSEBu6lnQzVPdzC5XWIzBCJ7ip2+LU2kICo1ZSsqekNZPqaqbko=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(7146999003)(10067099003)(38070700021)(11063799006)(56012099006)(261021123027099003)(261102123227099003)(261022075727099003)(261028144727099003)(261026140227099003)(261021121427099003)(261009223027099003)(261022105027099003)(261026121527099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GGNbDRoMML7+mZiqPPVVRbcF8PvOtOB6nQqCJfj7c/3NjUmkm3sFA5nrOv?=
 =?iso-8859-1?Q?vF2EotEmb2ggm/CACnYMKlnjXXG1tofQhP/+b9ce3I8aUAYYUywgTGB1m+?=
 =?iso-8859-1?Q?tQHFQTVBykanfEm7fvryrTldMBRfHBd3Oq/7oA00rSEnF5qh3x8Q1aDayT?=
 =?iso-8859-1?Q?WwOujvphWiHUV3AYga7jwS4XbBW++ROyEXXwP30IQ/l7sB+ELOfzgL4p3E?=
 =?iso-8859-1?Q?oZB8tfahVtDFPzIXgjuSRSoEwrmlUSCLsCj/vqZDAmFjk2+vHJnwm3ygyK?=
 =?iso-8859-1?Q?mShWWMkBfV6dLJLwbqYnuttHmje2YTl6+4k9ahf+IHlq9JATV7wOc/Oj5W?=
 =?iso-8859-1?Q?joIYNOFTG+RX7f0XczQsZrbUxxKBN9/KOI9qJtEHhs7zVI2i5D8u42B3MY?=
 =?iso-8859-1?Q?WYTuBH9SBOhStLUzWKfKZgNP90m/XCpjV7qFYFKU2KsstufxTIYbkOXFJ5?=
 =?iso-8859-1?Q?HtI2snVdR3vL/L/1hYKzZcfZFIhGtQlnYnC3E+KrZgVvpve4eBmHAt8I4i?=
 =?iso-8859-1?Q?rX8BU6CpNqphYAIjjKtUyPg/61wWu8Mayb9OTcg6duGw5WL6MGSUsApSw/?=
 =?iso-8859-1?Q?fZ3Xnu6C9Z1Gslw4YPw0DPM6hCizvnbY2gH2lQpYF2Dy+pAYE0pMflGfat?=
 =?iso-8859-1?Q?iX+0cmqFJopLMiCgvbPrhQmRFmOhrzgzU01vqvaHFnp/QcAZEGTZKAZ0OC?=
 =?iso-8859-1?Q?iV/zGqYlnRF/9sVvdZzVmtnQjdg4U8KegqW0h1/iSsQeU7q/Uwf1kh44Nv?=
 =?iso-8859-1?Q?ybrqC7tBjS6WvYrB6DhUSkmP0IcSnRV/IcesyhcPyp9SQ3cE/w0mFxKicc?=
 =?iso-8859-1?Q?+QdK3WgWtkYmS6YzqkJwYm4USKWt9d/DWsKFTbT3atNjnfWR1RZC/FTiwQ?=
 =?iso-8859-1?Q?tRX4qTNGYKyXq3Jieg9exG+Gva/hEyseENsSP3TkK0+bG5By1TRwYAqfQM?=
 =?iso-8859-1?Q?6bHM7Hq5tIeswAQWpWwke4dONeY6WqHRvb0JEVVaQVupAiUq7iX2elE7jF?=
 =?iso-8859-1?Q?M73FfAHqnJk3bcYwhyci6T/j+Elda8+hQIdjHlAHR8wTzoXjr5b+YiWolw?=
 =?iso-8859-1?Q?RtGjHw1B+Q5cnXzw6aQMBsJ9RTksZvsmx1LykEEkbH2UsJRis1XpJGdbhg?=
 =?iso-8859-1?Q?BoEQpSdVx1m2bkyaaI3sBIe/NEKssVSh3Q6ZdMHVd3jzKAHGN4doXsXPrl?=
 =?iso-8859-1?Q?af/ic8yMXOls+dvDUbjU1Xb7GbPUrCcs4yNO6OVU45RgpmeW3hYKG4kJnv?=
 =?iso-8859-1?Q?PzQwsJUFo8HiVZxvz5BTgDzP5QOQx8jCyXPbm7fsM0ZRu6lvK6YSJiSt3T?=
 =?iso-8859-1?Q?RtZoJzRhl99uCjGqy43ELuFFA9Bq7XYjGilb4/jIrAVnOfHV9yF5K9tRnb?=
 =?iso-8859-1?Q?McrzT8Wp0ZJRQRLRZrnYtUMLQbiF/xjeoa3qlnVMn5/NN4IThDvEEh8EGV?=
 =?iso-8859-1?Q?jnnBwQGgbRb+s5z+IuvtUOdCn/ZPlDlHH/JdUNmMSZSJ90pbYM8yLIOoRd?=
 =?iso-8859-1?Q?JBo3Bfx6R/6E/sazWMWoWXKUdoB3v1si32HaAPvxoA8rva4UqoBdUdJlfB?=
 =?iso-8859-1?Q?WenlbZ/BGQaBaPgcc1EwXym/UL29BFJFj1dVgcHnNix4g4JaTvYG1tpBft?=
 =?iso-8859-1?Q?Kcl1bBIkzX2E7ZuAHPOjkMb/2Mb7JtRaeveY5Jo6nkw0UPHbwMPYgibIcW?=
 =?iso-8859-1?Q?VmSNOXwUg/9P+EQ+DPXJy698PU1EKCY6aNyX4NPWpD1/24cLuoIS8Nm4d4?=
 =?iso-8859-1?Q?+XEliv2/MNBdY4k8wZau/gF9+lQJ+ikhnV5y9EDMqxm2Nv?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB6375.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e7570d-18d6-483e-f4a4-08df41a434ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 16:36:02.7805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28dg3qb/PlhG6EH6mvnBjrN2AzWacgczCKAaBz5h5ml9rmimvn6AZr3M5JxNa0mmxkjzereDPU6ho9y2xJzK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB6829

Thanks for helping to clean up my patch Sean, appreciate it. =0A=
=0A=
Signed-off-by: Chris Oo <cho@microsoft.com>=0A=
=0A=
Thanks,=0A=
Chris=0A=
=0A=
________________________________________=0A=
From: Sean Christopherson <seanjc@google.com>=0A=
Sent: Friday, November 13, 2026 8:25 AM=0A=
To: Sean Christopherson <seanjc@google.com>; Paolo Bonzini <pbonzini@redhat=
.com>=0A=
Cc: kvm@vger.kernel.org <kvm@vger.kernel.org>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>; Carlos L=F3pez <clopez@suse.de>; Stefano G=
arzarella <sgarzare@redhat.com>; Chris Oo <cho@microsoft.com>=0A=
Subject: [EXTERNAL] [PATCH] KVM: SVM: Sync CR8 to the local APIC after mark=
ing the VMCB clean=0A=
=A0=0A=
From: Chris Oo <cho@microsoft.com>=0A=
=0A=
Sync CR8 from the VMCB to the TPR *after* marking all VMCB fields as clean,=
=0A=
as syncing CR8 can toggle the CR8 write intercept and thus mark INTERCEPTS=
=0A=
as dirty. =A0Clobbering the dirty bit can result in KVM failing to detect C=
R8=0A=
writes if the underlying "hardware" uses the clean bits to optimize VMRUN,=
=0A=
e.g. when KVM is running on Hyper-V.=0A=
=0A=
Failure to intercept CR8 usually manifests as hangs when running Windows as=
=0A=
L2, as KVM's view of vTPR stays high and so KVM never injects pending IRQs.=
=0A=
=0A=
Fixes: bb365a506b1e ("KVM: x86: Unconditionally recompute CR8 intercept on =
PPR update")=0A=
Cc: stable@vger.kernel.org=0A=
Cc: Carlos L=F3pez <clopez@suse.de>=0A=
Cc: Stefano Garzarella <sgarzare@redhat.com>=0A=
Not-signed-off-by: Chris Oo <cho@microsoft.com>=0A=
[sean: rewrite changelog, massage comment]=0A=
Signed-off-by: Sean Christopherson <seanjc@google.com>=0A=
---=0A=
=0A=
Chris, as mentioned, I need your SoB.=0A=
=0A=
=A0arch/x86/kvm/svm/svm.c | 9 +++++++--=0A=
=A01 file changed, 7 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c=0A=
index 581bc3a23c95..3152846a6ccd 100644=0A=
--- a/arch/x86/kvm/svm/svm.c=0A=
+++ b/arch/x86/kvm/svm/svm.c=0A=
@@ -4726,8 +4726,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_=
vcpu *vcpu, u64 run_flags)=0A=
=A0 =A0 =A0 =A0 if (unlikely(svm->vmcb->control.exit_code =3D=3D SVM_EXIT_N=
MI))=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kvm_after_interrupt(vcpu);=0A=
=A0=0A=
- =A0 =A0 =A0 sync_cr8_to_lapic(vcpu);=0A=
-=0A=
=A0 =A0 =A0 =A0 svm->next_rip =3D 0;=0A=
=A0 =A0 =A0 =A0 if (is_guest_mode(vcpu)) {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nested_sync_control_from_vmcb02(svm);=0A=
@@ -4758,6 +4756,13 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm=
_vcpu *vcpu, u64 run_flags)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vcpu_to_pmu(=
vcpu)->global_ctrl);=0A=
=A0 =A0 =A0 =A0 }=0A=
=A0=0A=
+ =A0 =A0 =A0 /*=0A=
+ =A0 =A0 =A0 =A0* Note! =A0Any action that might dirty the VMCB must be do=
ne *after*=0A=
+ =A0 =A0 =A0 =A0* marking all VMCB fields as clean, e.g. syncing CR8 can t=
oggle the=0A=
+ =A0 =A0 =A0 =A0* CR8 write intercept and thus mark the intercepts field d=
irty.=0A=
+ =A0 =A0 =A0 =A0*/=0A=
+ =A0 =A0 =A0 sync_cr8_to_lapic(vcpu);=0A=
+=0A=
=A0 =A0 =A0 =A0 /* if exit due to PF check for async PF */=0A=
=A0 =A0 =A0 =A0 if (svm->vmcb->control.exit_code =3D=3D SVM_EXIT_EXCP_BASE =
+ PF_VECTOR)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vcpu->arch.apf.host_apf_flags =3D=0A=
=0A=
base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e=0A=
--=0A=
2.56.1.703.gf848ed807c-goog=0A=
