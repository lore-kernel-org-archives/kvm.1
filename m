Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=3.65.3.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793298072;
	b=yvmgZjstmcL1nDvSttRhfStqEfANdlWb2CQNzPFBaRKrTEk7EsUP0kb8uVMqFHiHj2ez
	 SV3OkAo46we3FUIFy3273a7hgVEPC7qoEsLy7gzRVkHnPAl2GRygyxhmqbSxZRU4xtlMK
	 Z5W85qrWQtHAMXERiRbnjImvdXkqp8V1jwxTv+I6RUfCTMIvKOkJzgXzeEPpPgNgLiOIZ
	 WNyMZQrDgdT5/BJdamMHbw8YqJJdGbSbpIQfNml4EYciqYLdU2T/xZyXzia8CMVLd/cOi
	 01xP5mugvUiLQT++3znwuCUYpO9smerNMiNLBd2lAClq4LkA+9fOFqh+T+xqUoOYDCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298072;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Subject:Thread-Topic:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:Received:Received:Received:From:
	 To:CC:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=wp1cWBwWPcwQS3+FbhbU4sD3NcxkeOH9Zi76W09AwPI=;
	b=ktpxszz3pT4G8waTYsUAMKw8RE1MZYqD0C9rWFqoeUM9KuQJM8JnxuYTVX5c3gTMMQCe
	 J5LJZ2A0KL2qjz4JilFD9bPB7MD55mrK6KDFzSipDHbxyJsVyjZYgYF8GDxHvbScYpNy8
	 xv3CEO2zMHqFbdVJGKNKtheJC8RYw5/RGgpnNO4VQqsmI6vc9VgIktQUBy4t30iUw6ppx
	 4mFJoYUbWvi4xBPSdsbphY2AP/dKclgQUab9roSrc5oxpYq0YA2fywJlSVDrl2k/xPNNt
	 VwPTfAwCDgj66F6BNmaeeVRsHpGuYu1acstCesK3Oc8Fi0AwkIl56hYTyaaTT49Jlzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="eG/VAE2p";
	arc=fail smtp.remote-ip=3.65.3.180
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A30606A31A;
	Thu, 29 Oct 2026 18:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8A30606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=eG/VAE2p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793298072; x=1824834072;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=wp1cWBwWPcwQS3+FbhbU4sD3NcxkeOH9Zi76W09AwPI=;
  b=eG/VAE2p/4LRzytQdn1BWwlXCwbZ+MoqtYTf7Y+ojsiTqh4i1J9/E2wR
   VLIVyxTmXfgT+dknbFmfjOo/1+nLKGgLflbESJjkdwXflJZZRF+oSweLW
   4DUYng+Za+HZnnhBBalWaQtGNxbPiEjxVY6vA2DbWhzt83vl0r0LJzIHc
   ffmYQrwUhrOyyWBqjhQy+kcJW5St8Qu1+ff8XE6MU5+bRCNBn8hRv4W00
   jwgQH6C4SL7c/2RqKnMNiUVaMkngollwvjbf7/+HcBYq9EsRHH01E9prl
   xwXzo0H+TozLashgxCvX6EAqyW2FfXvIy8G674DRIquyD4nY0GQscsk00
   w==;
X-CSE-ConnectionGUID: HucsxeKRTWCTaFLuMAoVUQ==
X-CSE-MsgGUID: jtah4oYOTtCozCisFNDBUQ==
X-IronPort-AV: E=Sophos;i="6.27,184,1787011200"; 
   d="scan'208";a="21993232"
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Add automatic prefaulting/prefetching for TDP
 MMU faults
Thread-Topic: [PATCH 3/4] KVM: x86/mmu: Add automatic prefaulting/prefetching for TDP MMU
 faults
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:21:07 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.236:7661]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.43.67:2525] with esmtp (Farcaster)
 id a02ab543-3315-4e6d-a69f-abbeee66427c; Thu, 29 Oct 2026 18:21:07 +0000 (UTC)
X-Farcaster-Flow-ID: a02ab543-3315-4e6d-a69f-abbeee66427c
Received: from EX19EXOEUA002.ant.amazon.com (10.252.50.139) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 29 Oct 2026 18:21:07 +0000
Received: from EX19EXOEUC002.ant.amazon.com (10.252.51.145) by
 EX19EXOEUA002.ant.amazon.com (10.252.50.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 29 Oct 2026 18:21:06 +0000
Received: from DB6PR07CU003.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUC002.ant.amazon.com (10.252.51.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56
 via Frontend Transport; Thu, 29 Oct 2026 18:21:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCsw1d096WjLOwI3D/91ZEBRyCw+CqDJsPFJv1bQshvBo7ca18PJSTmgp5+t4C0xRWo8iRUGL726sEHzfnNWbSFJVSnpXFH+wnlddGT0BGG+1w21Df8FXepmCPMepIf8kI32gz2FL2ieaWN2IBlTYLRmJTl8i1I2eGhE1J4LYERRXTYGVuTZfvNiNz4alctk+cPB8PdLPYBJ584XLO47U1mnyuB9F2eMtdJuTMgvURxNqC47aOSRiEBh3EEATJbTbKDoAYSlnPjFRJn5Y1ZEz5w5wN0VBEqYChRl6rXabyAnOpP4pYG4uSbSiJg4FUJEK1hbyMyv0dgMkNBUOgNGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp1cWBwWPcwQS3+FbhbU4sD3NcxkeOH9Zi76W09AwPI=;
 b=U9yxgXiissteoP3SXsc7KriyRgvoxEvsr+pgnXWmPurm83UcRy/1T5bX2AGo4pRQuh5WGMTFb8pZJ1l4CDQGp5vHlTc1SQRakQPvp5E5cGxLIoVaT2pXBDDQbPDlvNrEmLVaPReOEoRRsRycsycduTzUlPMuwDrbPCua+G6dhre4HWtbMLyR1EKB+AYsRs2fJHJfzItcGI5rCjT6z5jMGIa5jQpjgTs5XOvjeTN3kWSzomM6GmLbZun2ORpFjUg998WJKWDBJDk8QOKRU33xqUC4G01RJa1GU2fdCSk+aP+qJhqEqJ00xcEdS8r0leoDp8q2Vz5MLD5YHgQSJwzzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from GV2PR06MB10711.eurprd06.prod.outlook.com
 (2603:10a6:150:2fa::20) by AM0PR06MB6546.eurprd06.prod.outlook.com
 (2603:10a6:208:193::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 18:21:05 +0000
Received: from GV2PR06MB10711.eurprd06.prod.outlook.com
 ([fe80::ef79:3e5a:90ef:ae71]) by GV2PR06MB10711.eurprd06.prod.outlook.com
 ([fe80::ef79:3e5a:90ef:ae71%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 18:21:04 +0000
From: "Marangoni, Marco" <mamarang@amazon.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "cc-open-source@amazon.com"
	<cc-open-source@amazon.com>, James Houghton <jthoughton@google.com>
Thread-Index: AQHdZxq2NIaSsqoYoE6jc7QaLU6KRLcTftSAgAFBcU4=
Date: Thu, 29 Oct 2026 18:21:04 +0000
Message-ID: <GV2PR06MB10711171A7A8F225207FACD6BB96E2@GV2PR06MB10711.eurprd06.prod.outlook.com>
References: <20261028202607.1844883-4-seanjc@google.com>
 <20261028215143.2913059-1-jthoughton@google.com>
In-Reply-To: <20261028215143.2913059-1-jthoughton@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR06MB10711:EE_|AM0PR06MB6546:EE_
x-ms-office365-filtering-correlation-id: a48e7553-93c5-4f38-572e-08df35e964f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|261028144727099003|38070700021|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: l4tzHqQ3bpMJXlk4d0H0jgFhpZR7Z/Jm+Ih6X1DCj4Ss6X/fY55NoDhCfsJs5gncAcQMoDAEpD7K1lud740uxRCholUeexDfMh1Q0nSFnw0mj/hS+1JvoleSvGxRFSEIgkkr/SosTxB3stjsK4J8IB3P0lq00BWtsuIaF4rgIvlBYq0U3SGfYgOkYvOrh9AxCRosl0RSISSX90feZi2gzQ8rGX+Vnukt/h3zY7JLXXaq0f54AypUEgNlVg38jshtUgru1B1Ev3B8hKLyqIvS0Q6sOxJxeCuCuPJer0i1zXczelYktspDoWJoAtq7EUhEisYqmlJMfa2+SHQzLrlaI9HF2VcopLuv+0RiA4CU3n/3IQP54VE6GycLSem3HzchPMVrtkNiqP/hLxluIfXdcKveXyRKOD0kNL4ShvKUfzfHbHBF6nGgj4FqYWpPL4dSJ7EtAGnNeqIhD3aARO4CCzV5KxJTIlvYBskaday9JeC98+KirXyqh/zqLO50GtRCq65UHLEi/Y7U1yWJIWu/fXrkH7Y4kCEdMqIeqUlVcEQfLOa2drsyyGULbJVCPc8s9gvlTX2bRB1xZMjPogm7oHyZXTiIwMuSE/GTT9U9pX6olfU6lMx6TDeVvNwpdnXD7AObnNz3LDyvQyqCKHPEz+P/Qr0RIAXuKr46qRrnFRyFzDaGyux3xFQnvlkbV7xd45+WmgZ4JywjI/6p1+UfuM/TcVjOyi8CtapOsq7ccLc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR06MB10711.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(261028144727099003)(38070700021)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFFQSzRoMk42V0lKUkt1d0ZmZHAvYVdxdzZyb01kbnBCaW9WcXMxODlHQmpj?=
 =?utf-8?B?bkx6MCtHcTVTdm9URE1lL1k0OW05YXJwakYxSEpRWUFnKzJPVVU1WnRRdkpz?=
 =?utf-8?B?ZXlzdlppT0w3RFB6Titkb25WMHJTZUVoVVdmdldWVU9SWGY1VVBYTzEydEM2?=
 =?utf-8?B?SnlvU3kyZ0VsckdNbS9UK3FlTEt6M2F0TUlWMHhiQlRMaTM1b25uYnNheDRT?=
 =?utf-8?B?cTVXcUY2Zi9SQy9YUTl6czh0TDl3dVBZZ2graklzTUc3WDUrOXl5QUdHUUFr?=
 =?utf-8?B?YldZV1pMMW1PUGg2NjZwbmhaeVpKQlo5ajYxSWYrY24vRlNhd0dHVG9SMTRG?=
 =?utf-8?B?ekZadGt6cFhOZkZPb1RYajlueGJPdFhmalBycGhPZGdBQzczWHhBa0tCY0tG?=
 =?utf-8?B?OVBJb3JwYlh0VGJWNVdMOHRQbE5LL1laVDIxMzVYcXJGVk13a1NXL0Fyb2U4?=
 =?utf-8?B?MjhocmlIT3NmUDB0VDVjNlZzZkhJaXJ5NFRVUE9XZkpodXcrcGtPbkRiUjkx?=
 =?utf-8?B?Snc1K0szUitlZUFILzY0MDB3Z0RWSnZpMUFKLzJXNWExWVZrdytSQzdialRM?=
 =?utf-8?B?TGdFcXpUazlZZ2FtM1RpTFNMc01UVjFodTMzWFQwbUNMSGhNZXNvT3I5VWdk?=
 =?utf-8?B?Tk5iYllWRjN1ekszb093R3hBdHQwMlFoVklkK2dpWHlrMlRLNFV6anozRnFt?=
 =?utf-8?B?U0RjL3JrMjkwOGJROWluWWVQekE0OTM0MmliVUZrM2lHV25zZW0rbTdjV0hR?=
 =?utf-8?B?azBUU21KRTNhZGFNcEFWSGNhdVQzOG1qQm1KVTUzT1FJMzlOTndzU1RERjAw?=
 =?utf-8?B?ckdHWjZXRSswMWREZ3EwUlJkYzVkdHM5QVpsb28vZmN4Uk1OMHl5WlArL05K?=
 =?utf-8?B?NHQzREFqT2JJTVVKOFBsMFZRVnMwT2hiK2J6bklVN0IxMkhOcmM3YXBpanlv?=
 =?utf-8?B?TUphVWNOZUk3TGJ3L0xkTkIvenJJeElWcnlUUitJUi90UGorVGZuSk91eW4w?=
 =?utf-8?B?cG1xL1hIN3hxZkI5WTlhR0ZSRHBmTUdwMWRocFk1cldSOGRXYXZ1ajZNbS9u?=
 =?utf-8?B?ZU41bG01TWJ5QVM1dm1UUjhRb0NIVVRNTTh2ZUg5RW5JWHh6eXEwT0ZGSm5v?=
 =?utf-8?B?WXo0YXFacXp3ckp1S1lhdkdUSmVkRmdiM0JwaWtxRVMzSGhZY01DMHJiQzky?=
 =?utf-8?B?VG44ZkpQVnM5cVlnZ205djFQSXpqWll3V1R3UmQvOEZVcU05dXppUzFGQVM2?=
 =?utf-8?B?d1hQVllldGRmWnorVWdOckR5UWJ4eC92cXJRUThFdEU0b0VVdGRYTUhtZk1U?=
 =?utf-8?B?VHVwbE5LM3krNVhSYVBiYWszb3NZMnNZV0gwRGF6MEdzVWdRekJaNnNmbkJU?=
 =?utf-8?B?UWFUdjVpRTBmMmhMYlJ5Sko3ZDFkdE9ianZlNHhJczk0S3JkbVNDWU9ldUk0?=
 =?utf-8?B?dFdKWFlSSHp2ZnF3SjNnTVlVZzEvTWFHMXpFQlQyU0NrUStnVnBscUs1c25R?=
 =?utf-8?B?R2x4cWw3OFA0MFUrT2FzMU5GNTNwRFpBRklkTVVLTzNmYldvY09ZZUNYUVAx?=
 =?utf-8?B?d3FjZEpFMG5QU3U2WktwMUh4TVdoTyt5eno3SndEV3J4cThzQitVbkNkZ3ZV?=
 =?utf-8?B?RDZuZHpDZkl1bmREV3pCdER0N2tJUS9tV2ljWkthKzBTbXRkQkFNa253bnFO?=
 =?utf-8?B?YlBxeEMyNkJtVGQ5QVMwM1RrSGZFWnRwY2h1dDNmTjNLeVNPMkhFR3lpRTR2?=
 =?utf-8?B?UEhLaW82NHJLSXZ2WEFEc3B5TXJKVW9vakMxa21JdGVYdm96dXpBUGFKdFBq?=
 =?utf-8?B?a3FFRlNmMmlDeDVRblR1aGRrSm53R203MXg4REhuMU5mUVROS1lZUVhaVzJS?=
 =?utf-8?B?ZDlLWEJEWlU1QXpkVStFVWVYckVWTVdZOXoxRkpPQkJKbGhONWs2WjdvSWY2?=
 =?utf-8?B?R01MN2ZYTmdvTWNyaS9hd2w2VHpXWTdEZTRrVkd4V1BKMFJjN3VPcm1TS3Yz?=
 =?utf-8?B?TURxd3JZZXVCeWZkeVo5UGxwU1NneE9VWTNjZFN6VWNBTnpQeVBLM3YyMUlS?=
 =?utf-8?B?d01nRGpzTGYxQW9abmJPRWhycExXK0RXMzgrUzArL2lRNnJ4TjMyeW1zY3du?=
 =?utf-8?B?Kzd3ajFrbXR0ODRDYjYyOTZLMmd0K05sYkk2L0J3K0s4TFdIdUdzZTY2Zlgx?=
 =?utf-8?B?NXNvaFl1WlRpMi9PTzFuc3lMalhyWGRMc3k1dnpSa3crU1QrZ0FMemluRzhB?=
 =?utf-8?B?ZXJweVNKSEF1Zmo4dUk4dnBRRXJWRU1jZUIrM2ZmbHk0bklYbklYRVJML011?=
 =?utf-8?B?bUY1YTZ6V0dmd241L0ovZUpxQnpyUlpFRXlqOEJza3RVenVMQ003TnVjNWFR?=
 =?utf-8?Q?VEvNUSiNCA6stfTJwZuvjUlix0pp8PYfMsRU3?=
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
X-Exchange-RoutingPolicyChecked: 10zLDt83rhAQ7rzQe5ebOStNPx3yBeoQhUBJG68l12vfj5eSkpIuHc+JkeLsAnOpz23wfinC4ZehyKN8QvPSzMH73bIm5M0AYOEqAZb6ur6ZYvfE8Tf+sJ0bXgRgr41ZT9iOVGyYdCaJp2ahlxhmMXVcpmZitVWnA6jIUUfxgJ/oewINTrZRCQGg9bCY/y2Wu5ykz/dtAEw4kX+uUQE88uDrZuRLmwxPAFH8gEAYK8y/h2z6vxDcbSzYbRI8vUaXNhDreTU78o6BvpQS2kFlt64H64+50DlhnEFALc6veMN/NDwryfylsRBA23gKN1nt2/URvIPsM00UrdTbYjCElw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR06MB10711.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48e7553-93c5-4f38-572e-08df35e964f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 18:21:04.6978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CskhpZURoQ787LiQDq/x/qlFLJA3MJ//GLHBbhKnzMWfCnMJ98Zno5xxIzEzoiI5CnkPVASzv7L4j/fNzIQv/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6546
X-OriginatorOrg: amazon.com

SGkgU2VhbiwgdGhhbmtzIGZvciB0aGUgcGF0Y2ghCkkgcnVuIHNvbWUgYmVuY2htYXJrcyBvbiBp
dCwgYW5kIGl0IGRlZmluaXRlbHkgaGVscHMhIFRoaXMgaXMgdGhlIHRpbWUgdG8gZmF1bHQgMTI4
IE1pQiBsaW5lYXJseSBhZnRlciBhIHNuYXBzaG90IHJlc3RvcmUsIHdpdGggYW4gVUZGRCBwYWdl
IGhhbmRsZXIgdGhhdCBmYXVsdHMgY2h1bmtzIG9uIGRlbWFuZDsgbWVkaWFucyBvZiA2MCByZXN0
b3Jlcy4gQmFzZWxpbmUgaXMga3ZtLXg4Ni9uZXh0LiBFYWNoIGVudHJ5IGlzIG5yX3BhZ2VzOiBj
aGFuZ2UgdnMgYmFzZWxpbmUgb24gdGhlIHBhdGNoZWQga2VybmVsOyBuZWdhdGl2ZSBtZWFucyBm
YXN0ZXIuCgotIFVGRkQgNCBLaUIgaGFuZGxlciAoYmFzZWxpbmUgMjIyOCBtcykgMDogKzElLCAx
OiDiiJI1JSwgMjog4oiSMyUsIDQ6ICsxJSwgODog4oiSMyUsIDE2OiArMSUsIDMyOiAwJSwgNjQ6
IDAlLCAxMjg6IOKIkjIlLCAyNTY6ICsxJSwgNTEyOiArMSUKLSBVRkZEIDUxMiBLaUIgaGFuZGxl
ciAoYmFzZWxpbmUgNTQzIG1zKSAwOiAwJSwgMTogMCUsIDI6IOKIkjM2JSwgNDog4oiSNTElLCA4
OiDiiJI1OSUsIDE2OiDiiJI2NCUsIDMyOiDiiJI3MSUsIDY0OiDiiJI2NyUsIDEyODog4oiSNjgl
LCAyNTY6IOKIkjY3JSwgNTEyOiDiiJI2NiUKLSBVRkZEIDIgTWlCIGhhbmRsZXIgKGJhc2VsaW5l
IDUxMyBtcykgMDogMCUsIDE6ICsxJSwgMjog4oiSMzQlLCA0OiDiiJI1MCUsIDg6IOKIkjU5JSwg
MTY6IOKIkjY0JSwgMzI6IOKIkjY4JSwgNjQ6IOKIkjY4JSwgMTI4OiDiiJI2OCUsIDI1Njog4oiS
NjglLCA1MTI6IOKIkjY4JQoKOCBpcyB0aGUgc2VyaWVzJyBkZWZhdWx0OyAwIGFuZCAxIGJvdGgg
ZGlzYWJsZSBwcmVmZXRjaCBhbmQgcmVwcm9kdWNlIGJhc2VsaW5lLiBUaGUgNCBLaUIgcm93IGlz
IHdpdGhpbiDCsTUlLCBpLmUuIG5vaXNlLgpJdCdzIG1lYXN1cmVkIG9uIG5lc3RlZCB2aXJ0dWFs
aXphdGlvbiwgc28gdGhlIGltcHJvdmVtZW50IGlzIHByb2JhYmx5IGxlc3MgZHJhbWF0aWMgb24g
bWV0YWwuIEZvciBjb250ZXh0LCBteSBpbml0aWFsIHBhdGNoIHdhcyBhcm91bmQgfjc1JSBmYXN0
ZXIsIHNvIEknZCBzYXkgdGhhdCBwZXJmb3JtYW5jZS13aXNlLCB5b3VyIGltcGxlbWVudGF0aW9u
IGlzIHNvbGlkIQoKSXQgc2VlbXMgbGlrZSBhIHByZWZldGNoIG9mIDMyIGlzIHRoZSBzd2VldCBz
cG90LCBidXQgSSBhZ3JlZSB0aGF0IHdpdGggSmFtZXMgdGhhdCB3aXRoIHRoZSBub3JtYWwgR1VQ
IGl0J3MgcHJvYmFibHkgYmV0dGVyIHRvIGtlZXAgaXQgb2ZmIG9yIHZlcnkgbG93IGJ5IGRlZmF1
bHQuCkZyb20gbXkgcGVyc3BlY3RpdmUsIHVzaW5nIGZhc3QgR1VQIGhhcyB0aGUgcHJvYmxlbSB0
aGF0IHlvdSBjYW5ub3QgcHJlZmF1bHQgImFyb3VuZCIgeW91ciBwYWdlLCBidXQganVzdCBhaGVh
ZCBvZiBpdCwgc28gSSBkb24ndCBtaW5kIGdvaW5nIHdpdGggbm9ybWFsIEdVUCBpZiBpdCBtYWtl
cyB0aGluZ3MgZWFzaWVyIGZvciB5b3UuCgpJJ2Qgc2F5IHRoYXQgbW9zdCBzZXR1cCB3b3VsZCBr
bm93IHRoZSBzaXplIGF0IHdoaWNoIFVGRkQgY29waWVzIHRoZSBtZW1vcnksIHNvIGhhdmluZyB0
byBleHBsaWNpdGx5IGNvbmZpZ3VyZSBpcyBva2F5LgoKRm9yIGNvbXBsZXRlbmVzcywgSSBhbHNv
IG1lYXN1cmVkIGhvdyBtdWNoIHRoZSBwYXRjaCBpbXByb3ZlcyBhdCB2YXJpb3VzIFVGRkQgY2h1
bmtzLCB3aXRoIG5yX3BhZ2VzIGF0IHRoZSBzYW1lIHNpemU6CiAgLSA0IEtpQjogMjI4NSBtcyDi
hpIgMjMyMSBtcyAobnAxKSwgKzIlIChucDEgaXMgIm9mZiIsIG5vaXNlKQogIC0gOCBLaUI6IDE0
MzUgbXMg4oaSIDE0NDEgbXMgKG5wMiksIDAlCiAgLSAxNiBLaUI6IDEwMzYgbXMg4oaSIDg2MCBt
cyAobnA0KSwg4oiSMTclCiAgLSAzMiBLaUI6IDc0MyBtcyDihpIgNDY5IG1zIChucDgpLCDiiJIz
NyUKICAtIDY0IEtpQjogNjQ1IG1zIOKGkiAzMTkgbXMgKG5wMTYpLCDiiJI1MCUKICAtIDEyOCBL
aUI6IDU4NyBtcyDihpIgMjQyIG1zIChucDMyKSwg4oiSNTklCiAgLSAyNTYgS2lCOiA1NjEgbXMg
4oaSIDIwMCBtcyAobnA2NCksIOKIkjY0JQogIC0gNTEyIEtpQjogNTQzIG1zIOKGkiAxNjUgbXMg
KG5wMTI4KSwg4oiSNzAlCiAgLSAxIE1pQjogNTM0IG1zIOKGkiAxNzEgbXMgKG5wMjU2KSwg4oiS
NjglCiAgLSAyIE1pQjogNTIzIG1zIOKGkiAxNTEgbXMgKG5wNTEyKSwg4oiSNzElCgpUaGVzZSBt
ZWFzdXJlbWVudCBoaWdobGlnaHQgYSBwb3NzaWJsZSBsaW1pdGF0aW9uICh3aHkgZGlkbid0IDhL
aUIgaW1wcm92ZT8pOiBpdCBzZWVtcyBsaWtlIHRoZSBwcmVmZXRjaGluZyBkb2Vzbid0IGtpY2sg
aW4gdGhlIGZpcnN0IHRpbWUgYSBwYWdlIGlzIGdldHRpbmcgZmF1bHRlZCBpbiB0aGUgY2h1bmss
IGlzIHRoYXQgZXhwZWN0ZWQ/IEkgYXNrZWQgYW4gTExNIHRvIGludmVzdGlnYXRlLCBhbmQgaXQg
c2VlbXMgdG8gYmUgYmVjYXVzZSB3aXRoIGFzeW5jIFBGLCB0aGUgZmlyc3QgZmF1bHQgZG9lc24n
dCByZWFjaCB0aGUga3ZtX21tdV9hdXRvX3ByZWZhdWx0IGNvZGUgcGF0aC4KCi0tLQoKQW5kIGFu
b3RoZXIgcXVlc3Rpb246IHRoaXMgaXMganVzdCBmb3IgeDg2LiBEbyB5b3UgdGhpbmsgdGhlIHNh
bWUgYXBwcm9hY2ggY291bGQgYmUgZXh0ZW5kZWQgZm9yIEFSTSwgb3IgaXMgdGhhdCBhIGRpZmZl
cmVudCBiZWFzdD8gRG8geW91IG5lZWQgc29tZSBoZWxwIHRvIG1ha2UgdGhhdCBhIHJlYWxpdHkg
YXMgd2VsbD8KClRoYW5rcyBhZ2FpbiwKTWFyY28=
