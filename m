Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E8B3D7D7E;
	Tue, 25 Aug 2026 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.65.3.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691315; cv=fail; b=t83Zm6Ck+eYjH78uWHM58iHOmMJSj3rgxVMIQZxN3PBfY4+bEZ6mo9PGWR7BYuAmIAM4XTTsy0EvlGxowUnFhWU50XxiSvn9N4r0waniBJPVYuM4BQX2MXQFOXTtDmWaDlDDv0bAjIoETUWWL8GstEAHMdxdJAvLJssDvl1OCJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691315; c=relaxed/simple;
	bh=4tdpeQvUOfP2S996Lk77GYoDTOCUbdmee3i4sTI6gNc=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kDrc49PEXPXaA4mR+/g4OOU8+MZionxpYpmNxvWCgCAu3BxAgjGdVC3VPDlQFd9iUOWmv4vBDZx9DH+zOri6zJj2KMsazOTOn01+jyRzxZied9gPMdJMTK+ZbPuZySpWc5yN8Tya+/yrHAxM/Kafc2yGLuJ4mzokqGFxiYdFcV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HxfZ+kjl; arc=fail smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HxfZ+kjl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787691314; x=1819227314;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=4tdpeQvUOfP2S996Lk77GYoDTOCUbdmee3i4sTI6gNc=;
  b=HxfZ+kjlggQVh36uJRieZhYPPP16WOn4S8jTroomovIpl+hbag8S+C1Z
   tFl0ODBFpkGzfODCRTXMZFYaXoAgScZUIL2VNj7QN0G+EwKXPdpOo1MjQ
   9mz0zv2TChFAFj1yAP1NoBeD1OP/RMgm0kp4xZ4UoYJ1/i7xk7n9BBgTW
   rEqFua/0yReXQenua8Cc23n4XDPKNn0rbzDTIRyItoiIPMBGoOC6KlcCg
   78nbNev9DBIvbdXoZervG0DfWwTi8bEObAFP6u1h0+MkFeiA5B6Ua3ryi
   7QAhlL/qjQfp7qJlv8Zmw33w2SDnFV3G6v5rwAb1obrEkVbTb+6senSWE
   A==;
X-CSE-ConnectionGUID: yvXAe5ehS4mxbhqxGdQBdg==
X-CSE-MsgGUID: gbcpv9V8RxuN3s1IZdIGVA==
X-IronPort-AV: E=Sophos;i="6.25,243,1779148800"; 
   d="scan'208";a="18479784"
Subject: Re: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
Thread-Topic: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 20:55:09 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:29340]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.42.208:2525] with esmtp (Farcaster)
 id dba1434d-a9ca-4c7e-ab4f-d504f9bd29ef; Tue, 25 Aug 2026 20:55:09 +0000 (UTC)
X-Farcaster-Flow-ID: dba1434d-a9ca-4c7e-ab4f-d504f9bd29ef
Received: from EX19EXOEUA002.ant.amazon.com (10.252.50.139) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 25 Aug 2026 20:55:08 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUA002.ant.amazon.com (10.252.50.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45
 via Frontend Transport; Tue, 25 Aug 2026 20:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maix24tpvCZ8F38PNNBPyiLQp5+TbpH/v7zrtde8PHG6WewxUFJBNP0txHasWc4PLMQ+ppv5AZwHkh0/sS6BmxCZW3LIMnnpWqFMQRwWNJV49liIruH951+crSAvRcX2iPIFXBTq4FECwPhXeAcfUytmFsRBTyJ3Dc9shraT9MwA1P/1EKmxP7LIBRQqkabIleVEbxBXVjQCyyhB1BiNGeXdfTWBx120DCRk41n/1MROEXOvsxVU9dKO6T/+wIMGJVXIV6FvlMS0vpgY63WhSr5XKRPuSjgu6Ayl+h3oUXouxWBOY25Q0NU1FdiTxub6h5BAfAGNZoNKoTY7EdeMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tdpeQvUOfP2S996Lk77GYoDTOCUbdmee3i4sTI6gNc=;
 b=PXYKKO305ov0KWPCV137p7CwOwciJvToanbc0ukAnU8EwxCvRTvIZKWWNDJzn+ROIq5G7cLjryeCQ/YnMb08q0Wdi8QB1M27YFJB6uv0ZzEF71xzpMY/4EBdjXSmwSOGay3xEu55qKPlZh+x74FIGtwrL6/PpFC8+P2JqpLPezUFTZdWvGre4C5DU96NltfWmFL1WSdZ3hMt9CwGCLEpcRhtd0mRMEbOh+mIW8PPiIqPUuGUmxd6Q9q5XSQOp8E4xCQDEMf+7QF5MlfM3Xh8OpXcn+i92KteogTX87DKroLpUzpEfxxM83HlNcoejximKaR/APfwD4DHggVWhFS+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from GV2PR06MB10711.eurprd06.prod.outlook.com
 (2603:10a6:150:2fa::20) by DB9PR06MB7833.eurprd06.prod.outlook.com
 (2603:10a6:10:295::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 20:55:06 +0000
Received: from GV2PR06MB10711.eurprd06.prod.outlook.com
 ([fe80::ef79:3e5a:90ef:ae71]) by GV2PR06MB10711.eurprd06.prod.outlook.com
 ([fe80::ef79:3e5a:90ef:ae71%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 20:55:06 +0000
From: "Marangoni, Marco" <mamarang@amazon.com>
To: James Houghton <jthoughton@google.com>
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-patches@amazon.com" <kernel-patches@amazon.com>, "Mancini, Riccardo"
	<mancio@amazon.co.uk>, "Zoumboulakis, Michael" <zoumboul@amazon.com>, "Marco
 Marangoni" <marco.marangoni@proton.me>
Thread-Index: AQHdNJqdXqr/eEZTQESKiH5g17VLlbau7DOAgAAQ69eAABKCAIAAJncO
Date: Tue, 25 Aug 2026 20:55:05 +0000
Message-ID: <GV2PR06MB1071124601FFBC9FB38532F11B9AF2@GV2PR06MB10711.eurprd06.prod.outlook.com>
References: <20260825140159.70997-1-mamarang@amazon.com>
 <CADrL8HUcr5Fei1PX179bkFmMJ_S+eD267SVgc85cm-rpcahwmA@mail.gmail.com>
 <GV2PR06MB10711C9FE46F33B0613DCB66FB9AF2@GV2PR06MB10711.eurprd06.prod.outlook.com>
 <CADrL8HW8br9KuYoELj4id84ib_tGZrBh3zZGbjerHuM8uiN7hA@mail.gmail.com>
In-Reply-To: <CADrL8HW8br9KuYoELj4id84ib_tGZrBh3zZGbjerHuM8uiN7hA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR06MB10711:EE_|DB9PR06MB7833:EE_
x-ms-office365-filtering-correlation-id: c6fed525-b4d4-4a6b-3186-08df02eb2458
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|38070700021|6133799003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: +UYNET/jEUQRaaSdVKPWlMYKY9J1qemkPjUFha1kBXa9ZJCNGhzOkrRMrXdPJEPZSZ0nzFqJeJ/9E1p+rNa/toLs4VOisEWik//Y2PlkjJ0LHvsX/eDUuUgPD5SOfmfP42iwuL6q6HaK6ectmTTIqTWvbgXhp6ki1jdJdXlCGVlLhN5d0eXeYHKJO5Z5cHqeISY6aeAFMjWWV7udxsR1p3aRp+SQXcn7I1zTXgRNK8ICj1Rt/v+mWLLxWumOQ1P/gQFqqSjUoK+peaq1e7ygKpl7UyIoa3FA/gMB2Wu22tvCeSIxs76T6LcfFF2BDA9o4+USZE1Gkc0c1qKmtO/s5sFr7VWKdyOJkp9aggrS8RgljSSnf51rrVzXikev/ZBo52n9/by1cEhZ7lGXDZ2JLGRcHAqonPfJ7Oni4bWvWruLfSZ+YdkTsrO44Djv2/t8OQoGa9VgpIaiQM2ai5Nxdq/rL8vDX+DX+Rik5E0tCWA0/rVguQu5eotQG7lY++nVImJO3J1g1f12eAxi+pgrLq1vbG3Qqi+cYsa0WfvtU0+QILeZv8ILy7OfTIUTIk+KvXXAQsg5JDPv0AqdB7zdlV33Qfu7XLCkPGH/5CkBNN4usluiRGt+fcmcTexDCwCAx13ANdnlIGkdyofuQ5aYPmCFqu+znvgBy6TNS+QJp3gpvlsvZCJmF03HLfPf+Y0x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR06MB10711.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUUxSkNZdmtIek0yY2pXMFV4NEsrTkIrcE1Pd1lleUlXVHkvSXA3bHF5NTRZ?=
 =?utf-8?B?ZG5PU2hJeEY4Y3RtTjFJNTkrbFVQV0dkMEY0ZEFFNyttQjZOMWtJRWFyZGps?=
 =?utf-8?B?SHFXakgzb29tWjZzRjJUWnZZby9jNG1Za3N6SUtjVi8vQVlGOUhEaVpzSVNm?=
 =?utf-8?B?RUwwTzZwdy9KSkVKOG5PVE5VUkdjLzhyeXhsQXY2ZlIyREJobDZ5Sk9FbWps?=
 =?utf-8?B?STNRNTNlWnhVblo1bHZtSVF5eW01LzdRdThRVnl2eDljSmlNREQ1a2ZYcmYw?=
 =?utf-8?B?bENmTXF1N2lnWld6ZlpscyttUHk4eTlQM0MvM2twS2dhMFh0VlAzR0VGZnlH?=
 =?utf-8?B?eE5LS0V6bmpDUUVqcTBieEJMTDZkdjU4UFhFYytPUWYwd3U4N2Jick51QnRa?=
 =?utf-8?B?VVhmc0s3OXRCODJNMmRNVzIwK05EckdET1RLZE1IRmJ0c3BkQk9FKzZIWWo0?=
 =?utf-8?B?MFVRcUZBQlgvTHhvMkxrcnZhcWFsQ29qc2p1RU9hTFl5TzdzOFZvSlVBcVJr?=
 =?utf-8?B?ekwyWis3QzR3MXlEa3JFODFZR0VLWlpiWXRBRkdOa1UyaTdISnIrWm9EYWxN?=
 =?utf-8?B?NGRYcjRHVXVPSldtOFBtd0Yzb2xpOVZ0VkJneVVLTFRhcElMNkt3WmFpTG1I?=
 =?utf-8?B?dk1FOE51RUJ3OWxuNzVkU3c1U296Tjk0YnNKdXovMUpKOEtkcVd6UjcvbUMy?=
 =?utf-8?B?d3VYem9jQitYaHpIY3htdEZOVTFPSFYzcFlGdkl4cWQ3cnpLU3lnZ2htQk1X?=
 =?utf-8?B?bWk3a3hSa25tM2RkMFdzbnp3R2gzRWZVVVBKR3cxQ2pEaEVXbStPTVZCMEph?=
 =?utf-8?B?aEFoa042NElPOGdzRFRLaFd2UGkwNDRsOFZYRm5yb00rMkFHZ1JuNDE0UUlI?=
 =?utf-8?B?M2lEN1gxc2xGK1VPMHVXYkI4aEo5ei9XSzRYa3pCSUQrbVRGenU1cU9ucys3?=
 =?utf-8?B?cERGZit0dDlLVUVrY1lHTCtIZm5GeDcyeHYvM1NNT2NzNFBTcStlQmswVDNo?=
 =?utf-8?B?WXBOcE0wSU9mdDRCUHNMY0h0Um9WRjA1RkZJN0habzJPa0k5ZFdhdFFHbkdD?=
 =?utf-8?B?c0xESnErRDV3SW9FOWlyRy9ycCtlOTQyNnFvRW9KMTkzN0t0TUhNaXVMTmw4?=
 =?utf-8?B?cWpRMG96M1VDQlcwRWFpR3gzaUNLaWMvRFh4ejIzOWsxRjh6T2JoSWtTWU80?=
 =?utf-8?B?a09IUWlWSmI2QldJc0g5YWFrbG5SWTVZMEltZWhDUlNGMzcyeUFjZ3J5aUkw?=
 =?utf-8?B?WlFqdER6RWJxTGtBZ1k2TkFVWXFEWWpWMmcvN0dPMTlaQjhSbHBQalpPdHBT?=
 =?utf-8?B?cXF1UHZMSCtNdnE1MG9MaUxxZHlzdm5Qb0s0ai93NHBQME0zR004bFM4bHpk?=
 =?utf-8?B?QTFjRkZyQUFSZzVSZ0pSaXI1SzhtM0lqbW9vMFpybEpLamd5emZMMDZSaW1k?=
 =?utf-8?B?S3ZEaTB0dEw3UUNtaVZ0Vi9iSlVBdmhoVGY3ekZyblRGR1pPem1NKzNpaUxM?=
 =?utf-8?B?MnpIN21XdFpQS2lQVERyRDdVQTIwQjJKR0sraDYxTDhvVTRSV1FvNDNsd0Vv?=
 =?utf-8?B?OWdZMWQ2V1NzcmlYa2MweVYvWVF6d1YxM1hiS250b3BkQnB2U21pb0dRdXp0?=
 =?utf-8?B?QVRwRUVQUHBtL1R1NStHdzU2WmhXOUZUd3MxNTM3c3c3RnhzekQrWUQwQ2w3?=
 =?utf-8?B?TlFWMm5iNEhVZjQzUzVhSG5nWEw0WFpxVFdVK2loTFFVK1pOVjIyZCtJbzVo?=
 =?utf-8?B?VVBwc1lZN2Q3ay9SWXp4WVJLZTNRbmxiVHZYcmNTUFpYSUUyWVBNOTNxbVox?=
 =?utf-8?B?M3VEWGlxbmdYOUVnVG9LL0JkQld6K09kaFNSOEdReFpZMWpUTWowREs0MElO?=
 =?utf-8?B?MTd0VnFKbGxyejdLVFM2ZlZtTnVrUXJ0SFQ0c1FhM0kvUjdJVFBOL0NzUEwr?=
 =?utf-8?B?cU5TSzJQRk9kRkpFNkdxMmM4QzA2elZPdXlZUEVuMFIxcUlsVmxtV2lPZ2lr?=
 =?utf-8?B?NGRTd1N0TjY0ZEkrSGxabmhGTFQ0OEdwaXlNTzdvUVowdUlrT09JdlE3SURL?=
 =?utf-8?B?Q2FvenJnd0FJR25oSTJHWnVKRUxBUlFyUHhlVlRPNHNBajR4M0w3aW0rVmhM?=
 =?utf-8?B?MXBHZ0V2YzFIdlY3WmJ2Q3lvRVFJRWdZcGdQeHBjdG85NlM3MkxERWIzSkx3?=
 =?utf-8?B?elAycDc4OHViN09hZjg3OHkzYVNwbHRRMVZxcFV2OVdyT2VtR3hLQUFRM2xh?=
 =?utf-8?B?cHF4RmxUSjdwbUJuQnNGaTF4a3Q5UHNWWU04WUtHQ0JSeGFOTVRGSGFOZCtn?=
 =?utf-8?Q?vGFC/B8hb2aTfbEF2l?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KsxZQVh5X6fNb6Cm7tXydTCRzbCH7iULje0I0xrOjYWQItxVopiIMRTc2jtNvTt5497Iwnbq0d4tdmbLOdwLzZb5j9pl7gct+Y/vboCAmVZoRUv76NKAWqtczlmRtYSL1HGoDQmrUJn41A9hrU1y4Ms5lV9YAoKYCMdWGZbDSxNEuwbia+OPYixrSkgBwbgPOkpuAf++Ern9bcH0V4LokK4EW9cGAvL+4ZVAeD1iZkL7LBAT+hXijvgKBeVNlnivU2Y8vvkj2s2BoX2sFIh2KfTbfkfQyrw5Ui/jPXFvJicnsOZs+UFnJPQ4KAxvdMV+v+BIK9ppsZz0Wi7HsmtG7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR06MB10711.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fed525-b4d4-4a6b-3186-08df02eb2458
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 20:55:05.9614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2u420xNXUIZNZBUT2D5fsBJPaB9jarFSVezossiAgZT8AKt6/olff0Tu+W1p2Y4Jx8HoJJLyZL/1Vro2Y26XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7833
X-OriginatorOrg: amazon.com

T24gVHVlLCBBdWcgMjUsIDIwMjYsIEphbWVzIEhvdWdodG9uIDxqdGhvdWdodG9uQGdvb2dsZS5j
b20+IHdyb3RlOgo+Cj4gT24gVHVlLCBBdWcgMjUsIDIwMjYgYXQgMTA6MzjigK9BTSBNYXJhbmdv
bmksIE1hcmNvIDxtYW1hcmFuZ0BhbWF6b24uY29tPiB3cm90ZToKPiA+Cj4gPiBUaGFua3MgZm9y
IHRoZSByZXBsaWVzIQo+ID4KPiA+IE9uIFR1ZSwgQXVnIDI1LCAyMDI2LCBTZWFuIENocmlzdG9w
aGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIFR1ZSwgQXVn
IDI1LCAyMDI2LCBNYXJjbyBNYXJhbmdvbmkgd3JvdGU6Cj4gPiA+ID4gSXQncyB3b3J0aCBtZW50
aW9uaW5nIHRoYXQgSSBhbHNvIGV2YWx1YXRlZCB1c2luZyB0aGUgZXhpc3RpbmcKPiA+ID4gPiBL
Vk1fUFJFX0ZBVUxUX01FTU9SWSBpb2N0bCwgYnV0IHRoaXMgZG9lc24ndCB3b3JrIHdlbGwgZm9y
IG91ciB1c2UtY2FzZSwgYXMKPiA+ID4gPiBpdCByZXF1aXJlcyB0aGUgdkNQVSB0byBiZSBwYXVz
ZWQuCj4gPiA+Cj4gPiA+IFdoYXQgYWJvdXQgaWYvd2hlbiBLVk0gVXNlcmZhdWx0WypdIGNvbWVz
IGFsb25nPyAgSS5lLiBwcmUtZmF1bHQgbWVtb3J5IHdoZW4gdGhlCj4gPiA+IHZDUFUgZXhpdHMg
dG8gdXNlcnNwYWNlLgo+ID4KPiA+IEtWTSBVc2VyZmF1bHQgKyBLVk1fUFJFX0ZBVUxUX01FTU9S
WSBpcyBhIHZhbGlkIHN1Z2dlc3Rpb24sIGhvd2V2ZXIgaWYgcG9zc2libGUgd2UnZCBsaWtlIHRv
IGhhdmUgX2JvdGhfIGFzeW5jIHBhZ2UgZmF1bHRzIGFuZCBwcmVmZXRjaGluZy4KPiA+IEkgaGF2
ZW4ndCB0ZXN0ZWQgYXN5bmMgUEYgdG9nZXRoZXIgd2l0aCBwcmVmZXRjaGluZywgYnV0IHRlc3Rl
ZCBzZXBhcmF0ZWx5LCBib3RoIGltcHJvdmVtZW50cyB5aWVsZCBncmVhdCByZXN1bHRzLCBzbyBp
dCB3b3VsZCBiZSBhIHNoYW1lIHRvIGhhdmUgdG8gY2hvb3NlLgo+IAo+IFdoYXQgaWYgeW91IHVz
ZWQgS1ZNX1BSRV9GQVVMVF9NRU1PUlkgd2l0aG91dCBLVk0gVXNlcmZhdWx0Pwo+IAo+IElmIHlv
dSB3YW50IHRvIGF2b2lkIHBhdXNpbmcgYSB2Q1BVLCB3aGF0IGlmIHlvdSBtYWRlIGFub3RoZXIg
dkNQVQo+IChLVk1fQ1JFQVRFX1ZDUFUpIGFuZCB1c2VkIHRoYXQgc29sZWx5IGZvciBwcmVmYXVs
dGluZyBndWVzdCBtZW1vcnk/IEkKPiBoYXZlbid0IHJlYWxseSBsb29rZWQgaW50byB0aGF0IGJl
Zm9yZS4uLiBJJ20gZ3Vlc3NpbmcgdGhlcmUncwo+IHNvbWV0aGluZyBmdW5kYW1lbnRhbGx5IHdy
b25nIHdpdGggdGhpcyBhcHByb2FjaC4KPiAKPiBJZiB0aGlzIGRvZXNuJ3Qgd29yayAoYW5kIGEg
Vk0tc2NvcGVkIEtWTV9QUkVfRkFVTFRfTUVNT1JZIGRvZXNuJ3QKPiBtYWtlIHNlbnNlIGVpdGhl
ciksIHRoZW4gcGVyaGFwcyB0aGUgVERQIE1NVSBwcmVmZXRjaGluZyBsb2dpYyBtYWtlcwo+IHNl
bnNlLgoKfn5VbmZvcnR1bmF0ZWx5fn4gRm9ydHVuYXRlbHkgSSdsbCBiZSBvbiBIb2xpZGF5cyBm
b3IgdGhlIG5leHQgZmV3IHdlZWtzOyBJJ2xsIHRyeSB0aGUgcGVybWFuZW50bHkgcGF1c2VkIHZD
UFUgYXBwcm9hY2ggYXMgc29vbiBhcyBJIGNhbi4KSW4gcHJpbmNpcGxlIGl0IGNvdWxkIHNvbHZl
IHRoZSBwcm9ibGVtIHdpdGhvdXQgcmVxdWlyaW5nIGFueSBrZXJuZWwgY2hhbmdlcy4KCgpPbiBU
dWUsIEF1ZyAyNSwgMjAyNiwgSmFtZXMgSG91Z2h0b24gPGp0aG91Z2h0b25AZ29vZ2xlLmNvbT4g
d3JvdGU6Cj4KPiA+IE9uIFR1ZSwgQXVnIDI1LCAyMDI2LCBKYW1lcyBIb3VnaHRvbiA8anRob3Vn
aHRvbkBnb29nbGUuY29tPiB3cm90ZToKPiA+ID4gSSB0aGluayBwYXJ0IG9mIHRoZSBwcm9ibGVt
IGluIHRoaXMgY2FzZSBpcyB0aGF0IFVGRkRJT19DT1BZIHdpbGwKPiA+ID4gaW5zdGFsbCA0SyBw
YWdlcyAoSUlSQyksIEkgdGhpbmsgYSBtb3JlIG5hdHVyYWwgd2F5IHRvIGZpeCB0aGlzCj4gPiA+
IHByb2JsZW0gaXMgdG86Cj4gPiA+Cj4gPiA+IDEuIE1BRFZfQ09MTEFQU0UgYWZ0ZXIgZG9pbmcg
VUZGRElPX0NPUFkuCj4gPiA+IDIuIE1ha2UgVUZGRElPX0NPUFkgaW5zdGFsbCBQTURzIHdoZW4g
aXQgaXMgYWJsZSB0byBkbyBzby4KPiA+ID4KPiA+ID4gVGhlc2UgZG9uJ3Qgc29sdmUgdGhlIGV4
YWN0IHNhbWUgcHJvYmxlbSwgYnV0IHJlYWxseSB1c2VyZmF1bHRmZAo+ID4gPiBzaG91bGQgYWxy
ZWFkeSB0cnkgdG8gaW5zdGFsbCBQTURzIHdoZW4gaXQgY2FuICgjMikuIElmIHdlIGhhdmUgIzIs
ICMxCj4gPiA+IGlzIG1vc3RseSBhIG5vLW9wLgo+ID4gPgo+ID4gPiBXaGF0IGRvIHlvdSB0aGlu
az8KPiA+Cj4gPiBEaXJlY3RseSBpbnN0YWxsaW5nIFBNRHMgYWZ0ZXIgYW4gVUZGRF9DT1BZIGlz
IHNvbWV0aGluZyBJIGFscmVhZHkgaW52ZXN0aWdhdGVkLiBJIGRpZG4ndCBtZW50aW9uIGl0IG9y
aWdpbmFsbHksIHNpbmNlIGl0IHRvdWNoZXMgZXhjbHVzaXZlbHkgdGhlIE1NIG1vZHVsZS4KPiA+
IEZvciBzb21lIGNvbnRleHQsIHdpdGggdGhhdCBhcHByb2FjaCwgaW4gdGhlIHNhbWUgYmVuY2ht
YXJrcywgZmF1bHQgbGF0ZW5jeSBvbiBuZXN0ZWQgaXMgcmVkdWNlZCBieSA5MiUsIGFuZCBieSA0
NCUgb24gbWV0YWwsIHdoaWNoIGlzIHNpZ25pZmljYW50bHkgYmV0dGVyIHRoYW4gbXkgPiBwcm9w
b3NhbCAod2hpY2ggIm9ubHkiIGltcHJvdmVzIGJ5IDc1JSBhbmQgMjIlIHJlc3BlY3RpdmVseSku
Cj4gCj4gRGlkIHlvdSBvciBvbmUgb2YgeW91ciBjb2xsZWFndWVzIGV2ZXIgcG9zdCBpdCBvbiBs
aXN0PyBJJ20gY3VyaW91cyB0bwo+IHNlZSBpdC4gOikKCkkgd2FudGVkIHRvIHRhY2tsZSB0aGUg
dXNlLWNhc2Ugb2YgYXJiaXRyYXJ5IFVGRkQgY2h1bmtzIGZpcnN0LCBzbyBubywgbm90IHlldCBh
dCBsZWFzdC4KSWYgeW91J3JlIGN1cmlvdXMsIHRoZSBwcm9vZi1vZi1jb25jZXB0IGlzIG9uIGh0
dHBzOi8vZ2l0aHViLmNvbS9tYXJjby1tYXJhbmdvbmkvZmlyZWNyYWNrZXIvYmxvYi90aHAtdWZm
ZC9yZXNvdXJjZXMvcGF0Y2hlcy90aHBfdWZmZC5wYXRjaDsgaXQgbGFja3MgbVRIUCBzdXBwb3J0
IGFuZCBvbmx5IGhhbmRsZXMgVUZGRF9DT1BZLgoKCk9uIFR1ZSwgQXVnIDI1LCAyMDI2LCBKYW1l
cyBIb3VnaHRvbiA8anRob3VnaHRvbkBnb29nbGUuY29tPiB3cm90ZToKPgo+ID4gSG93ZXZlciwg
dGhhdCBhcHByb2FjaCBvbmx5IHdvcmtzIHdoZW4gdGhlIGNvcHkgaXMgZG9uZSBpbiBtdWx0aXBs
ZXMgb2YgMk1pQiwgYW5kIGZvciBzb21lIEZpcmVjcmFja2VyIHVzZS1jYXNlcywgdGhhdCdzIGEg
bm8tZ28gKEkgY2FuIGVsYWJvcmF0ZSBmdXJ0aGVyIGlmIG5lY2Vzc2FyeSwgYnV0IHRoZSBtYWlu
IHByb2JsZW0gaXMgYW4gZXhwbG9zaW9uIGluIGluY3JlbWVudGFsIHNuYXBzaG90cyBzaXplIHdo
ZW4gbWFuYWdpbmcgbWVtb3J5IGluIGJpZyBjaHVua3MpLgo+ID4gSSBtaWdodCBwdXJzdWUgdGhp
cyBwcm9wb3NhbCBpbiBhIHNlcGFyYXRlIHBhdGNoLCBob3dldmVyIEknZCBsb3ZlIHRvIHdvcmsg
b3V0IGEgc29sdXRpb24gdGhhdCBjYW4gYmUgYXBwbGllZCB3aGVuIHVzZXJmYXVsdGZkIHdvcmtz
IHdpdGggc21hbGxlciBjaHVuayBzaXplcy4KPiAKPiBJIHNlZS4gU28gd2UgcmVhbGx5IGFyZSBk
ZWFsaW5nIHdpdGggNEsgbWFwcGluZ3MuCj4gCj4gSW4gd2hpY2ggY2FzZSwgcHJlZmV0Y2hpbmcg
YXQgMk0gZG9lcyBzZWVtIGtpbmQgb2YgYXJiaXRyYXJ5LCB3aGljaAo+IG1ha2VzIG1lIGV2ZW4g
bW9yZSBpbiBmYXZvciBvZiB0aGlzIGJlaW5nIG1vc3RseSB1c2Vyc3BhY2UtZHJpdmVuLgoKWWVz
LCAyTWlCIGlzIGFyYml0cmFyeS4gCk9uZSBvZiB0aGUgcG9zc2libGUgaW1wbGVtZW50YXRpb24g
Zm9yIHRoaXMgcHJlZmV0Y2hpbmcgcGF0Y2ggaXMgdG8gc2tpcCB0aGUgR1VQIGFuZCBjcmVhdGUg
dGhlIEVQVCBQVCBkaXJlY3RseSBmcm9tIHRoZSBwYWdlIHRhYmxlLCBpbiB3aGljaCBjYXNlIDJN
aUIgaXMgbmF0dXJhbC4KCgpUaGFua3MgYWdhaW4gZm9yIHRoZSBpbnRlcmVzdGluZyByZXBsaWVz
LCBJJ2xsIHRyeSB0aGUgS1ZNX1BSRV9GQVVMVF9NRU1PUlkgd2l0aCBhIHBhdXNlZCB2Q1BVIHdo
ZW4gSSdtIGJhY2sgZnJvbSBQVE8uCgpNYXJjbwo=
