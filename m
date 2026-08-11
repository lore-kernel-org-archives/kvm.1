Received: from fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.156.205.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3274446EE;
	Tue, 11 Aug 2026 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.156.205.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456697; cv=fail; b=k1xA0kjV3rFNzLQ05n2VrT90AtSsv96SWKr00hjuXreopKrlAq8C/8HjAGU4yM9ijnE+rPwt4haBlC/29U0LxAqn3TkjUNOjnNjpFUbGm2cPqObaY3WzKJH9ymjgw45qYlEvU712ng9EwjzVqu5Lm88mtAm5V3ZRuY/UEcVxvTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456697; c=relaxed/simple;
	bh=DhDHoyRJGpajbY0LIaEQpPZvc1KU968o1zj1BtZ3enM=;
	h=Content-Type:MIME-Version:From:To:CC:Subject:Date:Message-ID:
	 References:In-Reply-To:MIME-Version; b=GWH2y8eN8A0zVokYhgiUFncUetHBWRa2Cgcci2iMWdGmAPPSQHN9q5r69HMyQHkS9weToBRucdx2EOxJZRC4aKKgtniAyVysLEDDvdh+RxKSg6+RidW3Tkp2r4G+uqT+j4Z5tOW3o0Hwv/7tCljJSCLejj3isjALV2kHwI20d/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=p9QnO711; arc=fail smtp.client-ip=18.156.205.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="p9QnO711"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1786456695; x=1817992695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to;
  bh=GQpkt8Y8c78fcDbWnsIcS+I6jY9lIaScqTE54OOjwIg=;
  b=p9QnO711ZS/ZLD8uiN3P8Ny4VJ+b0m4ZBpzUlwgTlac/xV6WXjFOpYbL
   Niun06ZSTW30+/K2Ft06cHpzlhv0Y0j8H3EUDrOs4Qv9tinc/jW+xE+K6
   j9JB5OduBhUJeTjYkHbEk1Ja7rsf03fYFep2IBkBT1A3hqatfXQ3JZRKx
   EV0sjKiqUBXrE9LELybxJQbiG23XdZSwrrcHTO5Mnt/b15nzLxVlrO0ze
   lHg2hqNGcUuWgy/WEhJzT0HOBeiifcJLFsHpYr2PVp7q4Vubwc62I/MzK
   KriTnHlhSmye6buK7uMbf1Q0bli4AIR5m2MEch3yoAbTjroT0CXYxd3lJ
   A==;
X-CSE-ConnectionGUID: ZPi4DIKwROqdwLP26y3z/g==
X-CSE-MsgGUID: CA0+EeLuTROZc3OTNrOaTA==
X-Amazon-filename: smime.p7s
X-IronPort-AV: E=Sophos;i="6.25,217,1779148800"; 
   d="p7s'346?scan'346,208,346";a="17412096"
Content-Type: multipart/mixed; boundary="===============0518466012104769306=="
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-001.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 13:58:10 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:23640]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.26.155:2525] with esmtp (Farcaster)
 id 1e8d4d81-339e-41d9-b6b1-b4f17826deca; Tue, 11 Aug 2026 13:58:09 +0000 (UTC)
X-Farcaster-Flow-ID: 1e8d4d81-339e-41d9-b6b1-b4f17826deca
Received: from EX19EXOEUB001.ant.amazon.com (10.252.51.80) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 11 Aug 2026 13:58:09 +0000
Received: from EX19EXOEUC002.ant.amazon.com (10.252.51.145) by
 EX19EXOEUB001.ant.amazon.com (10.252.51.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 11 Aug 2026 13:58:09 +0000
Received: from CWXP265CU008.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUC002.ant.amazon.com (10.252.51.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45
 via Frontend Transport; Tue, 11 Aug 2026 13:58:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvLkxJhOlv/xTGd1q+EgX9dQHamqs/hLb93BCBvqcCJMbKLZ1U6SMJw2JmSUp2PUKlvGnNBjxrnfszeDH+Y0TSO5J8yQNCfM5yhJRDUzPKF3EQ9Gha7VI+w+pQquFnVfenFNlIPWkQY0vUiMJnGlnTtAIUtQznP/vxP/quR9a96+D4HnbqmFAjRPGlUlkJQTuF6gzEQixW3mUnigrNEeyVYAzEXImV+U0qiWlmIIVVqVGM1gUm9CyFLtrY3jrv8Um/eq+oxjcGJ6g2GFEqdg5L1xgciYGvOUxImOk8gtwK5ehYDLS/t9quKFev2IJVqQVQ5HXIZ/MX6BOCSX42mogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=f+pL8Rho5ICMmAYM62kB1+7ddLQJ87vq9feYrWb2nXw=;
 b=cIVlojPsH6QHaqx/0OKP+/s2xJejCjE1XWGZVWBSB/Rvu7+EWRb/UrhByqEHOqreR6blQ+3y+QzB3RLo2d2RIhFWzsdGPy29BP4TezUM+3dyunzqZ0ZY7D+LMUOWKQIUgx38XI0j77WQjOoq7hcfBkrAgEMV03/GozBSl+hXNC5rKacmEU9XOBn++M7+yFqeDMGm25xakacKk5Bm1LelgJBH5zGr9/tFhPiVd4M8mgTBC6EOV2qrO9PF1LJWntvLGf1HXgeQoWOWVL6jn2Ai2kHGXlolcx0dFrDhOPm+yN77p73PvxusRFSiq06utUpQZucA8NUaU3nvTbQQmRMwKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.co.uk; dmarc=pass action=none header.from=amazon.co.uk;
 dkim=pass header.d=amazon.co.uk; arc=none
Received: from LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4b4::12)
 by LOAP123MB8244.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 13:58:04 +0000
Received: from LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c7e3:476c:6170:8f6]) by LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
 ([fe80::c7e3:476c:6170:8f6%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 13:58:04 +0000
From: "Woodhouse, David" <dwmw@amazon.co.uk>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Durrant
	<paul@xen.org>, Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH v9 00/21] KVM: x86: Cleaning up the KVM clock mess, part 1
Thread-Topic: [PATCH v9 00/21] KVM: x86: Cleaning up the KVM clock mess, part
 1
Thread-Index: AQHdKZlunTjOrM3UPEqBv2shc8qR6w==
Date: Tue, 11 Aug 2026 13:58:04 +0000
Message-ID: <1b28f8521323fc529a1562ad1f17cdc25384084b.camel@amazon.co.uk>
References: <20260810225500.869288-1-seanjc@google.com>
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.co.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOZP123MB8516:EE_|LOAP123MB8244:EE_
x-ms-office365-filtering-correlation-id: 318f0820-3169-4814-d715-08def7b090c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|6049299003|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003|38070700021|4053099003;
x-microsoft-antispam-message-info: 253jO8v4eMgKKoS1qvQ6sQ5A6MmtN7JtQ/DAhpLHamNiAfYc4s9TggiiUWVRcEJGtag9rtm780cmI2vrFxve8p40f7LMjCTKYlfL/0vO4m3KFPk1tWA3Fqa6LgrLBAmWwTJ3uPYuCPdx1V+d2HcG2TPsGDP1kBotnfEvNuliQxiUlDRY/85Uq2pj0MB05SK8kv75H6zo3YpcSWVSPqOa62wMp2w2hGLRcLkj73D0uVvSIGJs2c3D6vcXEhO6XdvdrNMco05SJ0S7BDXMOr/c55Hbb7bFBQrI15YRiQxgpQwn/pBggnUEcGkh6kOtML69mZaud9fq1oNpi2Idk8nAKoan3GIYrqYKNkjFKWPODqtv7qIPmr8R11wOKH5+UfY504MVEv/6nJcYJkYUjJyhcypGBwkfqen7dFAPmMoZLQij22UokMgYcDrmqv+nUHMuOSDzORV0d4xI+EYVFix1DPRT7QTibC4yCcE9m7VKyP3DJifw1kREQniUuVsQ9QQWGHx4Buchh34InCtjsTBOq+UZTEjnh9rG/lr4I6fiuOJyOW/BVk+W6DpA2Bzgtcwfs8C+RDKckgeK1BfKXU71UEBI3Cpdh1hTOuSUzY4WRiaXV82i+XkVHCK2AJIvzPaU1zDr+tKNiCpCsfjnVIH+cJ9eky3rSiIDmmaW0I9v9awY3utUjWEOij9JDQTjhFuTXrRmlkcmPvOUvRmQv641OaNLzh86vL5bczUqn6sF2pk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(6049299003)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUZteE5aSDdVU0ZJb3M4dVFHS1J2SWkwSGVIMko2c216dTNUaUNONCtraHJU?=
 =?utf-8?B?ZklWMGtWT1FXcXhVQUFvTDc2Mmt2OGcwaGxrVzNlMk9FUllldTNtalgvNVVy?=
 =?utf-8?B?Qy9xa1lKbDRqalVST29sbDZjOXZ3QzhNaWpxZUNtV0NIa1k3L3p0S2RQVkdx?=
 =?utf-8?B?NVY5U01ycjMyM0NySDRRRUdkOVBtelV4djNEMGJ4dnpyMGR2bFN1NGtMS09i?=
 =?utf-8?B?dzcwYkZ4OXNiNzg4Ymd0THFMS0RMSmJUejZaVkpFSzZtb0JUMzFhZS9ib2V4?=
 =?utf-8?B?NVFKQTlVSWIwWUs2YWFhcGZEUHlkNDNIaDBBSHBUcGpodkNRZEdrdVY1Q1Fv?=
 =?utf-8?B?Wjd5emZTTWdCMC85VzY1VjlYY1h6dVJsa0FpakprTm9pa1BGL2I5ZWZMWXp0?=
 =?utf-8?B?V25FV2R3V1lWekpjUmQxV2lLRkwxTk5ON1liU0txRmsyVnZkTzRaY2tmMzhT?=
 =?utf-8?B?bVBQYUZ0cnlsTFprdUFaaU5qY3kwazF1TTdBSUo2QkNXOWUwSUI1MmxncXVE?=
 =?utf-8?B?aEwzUHc2d1BqbVN3WkczL2s2U1IvK3pOaUR3Vm1UYVRTanoxS1FUZWkwYVlN?=
 =?utf-8?B?M1Uza2hxWXhGRlVJeFFQUnFSRUZTZVMrVWJCbFBKdkw3K0tPZXdObForeUlh?=
 =?utf-8?B?VVpOWHBDeXdLUXd1Yy9zaU1KSjRmeUsydFArZ0gvbHE3djJtUVVjTmc0dGE3?=
 =?utf-8?B?VjJUMUI3TXFBcW5aNHBlNzE0VkdZMXN3SW9CVkJPRW1BWTE5NjBETjNPb0NE?=
 =?utf-8?B?dzdORXgrV09YbS90VEtYNUdrU05SMkRiOExsZldXUDgzcFI2WW9ObEVUMEVy?=
 =?utf-8?B?NlpQWkZwcTV2NGJFZElML3pzOEp4anU1Ty9hU0pOSk5YL0ZJN3hKRk5TNmpP?=
 =?utf-8?B?cVQ4VWp5czFnTVc1SVIvY0NEQ3F6bTRzWVBzcDZyc1VyczNtTmhtOHVYTHRC?=
 =?utf-8?B?THNmVmRwQmZtQ1JOTUh6SDBEaWJiVGFtL09VZzZNNlpLU2Z1WkVPeDFsYSth?=
 =?utf-8?B?N1FkRENINnl4bnZIVHlDdE1JR3JGZlVrOUFuNzVQbklmRS91Z0l0ZnhjaGs4?=
 =?utf-8?B?V2ozdXlDbktyUVdFNWFuUEJnVkFWcmJKVCtZNndwcUpIVGFmd0NlNGRJaU9F?=
 =?utf-8?B?eDFoY3U4K1VuUGdudlVyNlBJcUlCVTNYcjh5b1ZlNFJFbDcrZnlDOVVtTnJu?=
 =?utf-8?B?cDk0Q2VvV3plODdGWm5Lc0Q4MkxSdzYyeGt5c3lsUWVsOXdkN0Zzc1Q0MzVS?=
 =?utf-8?B?d2ZHSUpkdys4WFRiRUNDZzFRRjNTbHNET2JaekZEK3p6cUMyMkpBcUF6RWh4?=
 =?utf-8?B?dWpHY2doN3lTRTNHbXhOY3pjQUJuT294R2IrWnFpMVUwa1VjeWRudHlkUTJl?=
 =?utf-8?B?MmJNTXRqNytkMzUxK1Jwck9jSnJldmNRN1V1a0hoeEhEOVNlRktxbFNFb2p3?=
 =?utf-8?B?ODRUeEtOczgwSStBSXhiUkdvRCszQjRJZnEzdGNVZHFqbVNqYXpRUE54UGhJ?=
 =?utf-8?B?UGF5WXBNT1VlK3hpYnZVTHNDMDN5bFUrSjhDdW43S2x4NkM3MUVkL0w5V3Nw?=
 =?utf-8?B?YzBQNmNCbVpjMnFPK1BEaTBRdHFUVjlBaTl4OTJzZDBoaXVMd09hSFc3K3BS?=
 =?utf-8?B?eVJvalhtUGpMRnJjSnVuZ21hMXI0RWlYZDFYeFpGUEpHMVdoL2VxWUxsWnVr?=
 =?utf-8?B?dU1nYnYvc1FwS2tXdnNNQURoRW52U0ZhQjVWYUNnSUN2NXVid3dVbGlVbGsx?=
 =?utf-8?B?WEpJaDEyNUNGcFFTN3FjRTF5L21CYWVFYWY1NUJGSUhQdHNIL0liZjNwTVVJ?=
 =?utf-8?B?V1FBZjZsejFwSUM3MFhaemxNMlhueXExbnVYRnB3RHFsdzQzOXI4dXkrU001?=
 =?utf-8?B?UWRCTnBwekVoN3ppNllqQ1I0UVViMC9VN2Nnek90dFUyZHcrQ2JIcGdYdXhw?=
 =?utf-8?B?NitSdXd0c2dhS2hlUXR0YWlpVFBBd3hTcGs3UFRsVmJoMmxab0ttdzI1dnNa?=
 =?utf-8?B?SFNBd0ZlWStUVFIyc285VkgvVWh4WVRzYlFyUW5idUNOc0VRcUEvaTNuNU4x?=
 =?utf-8?B?VTdVZjE5Z2RzL29xZWxXeXNkSE5SVnFhRzdkelN0MVpTK0h2ZGhaVzJIUGpX?=
 =?utf-8?B?S2hZZVVoUXlXZ3R2UWQ3WmxyNElJVmlqd3JQZTlnYSs4V3JzOENJeWRaaXlE?=
 =?utf-8?B?UlRQVU1jRjZmOW5aTjAvWVhyeEhyWnJIU3R0WnVHbDIyMWw4SnRWZHpIenR1?=
 =?utf-8?B?SnBvUy9RQ1hmOFRrL0EvWFNYSHdYSkJhc1BCVWhVVnNXYUVPNk1mZ0ZSMnRt?=
 =?utf-8?Q?/sSLVqiWBC1y621oYz?=
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fr/Mxvp3bwhpyZse6EdCWh+TmWT7Io5EGJ3ksW1KUa7Z+hzxQg2omjkzOM/2ONSNiyBXvc522Ocu2LSNxqSumLKxk8J++142gn6kPb/y8s5PpZI+wu7rrYcqhaQclWhbzvPCNmafETo2PnLZl/aXD7GDPWVXI/pzDzondyOz6LxoZT0lLtV+m0LKJPzVu9bMG0ZWcMCA+xaNje72l5/eb9/iufH9bL4BWLoe2ou4YTAJqn92vQRmYpy8W4+CRVVRGqHC8W93yxG2rw4JJPF3sRK8WnXQ9ixGfP4yVKDqEtLldJ3+iBstAw3qTpybCXE2p474j0fPvuXoCUZzNGJeJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOZP123MB8516.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 318f0820-3169-4814-d715-08def7b090c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 13:58:04.7894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fO2KCZ9scfT2Qg3VfGs3rH4/Ni17arukAskTUecCfEbm+VeHoW1uqfIJrOCo5JgY9ZMJO24EOfP7KYOXBvDXCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8244
X-OriginatorOrg: amazon.co.uk

--===============0518466012104769306==
Content-Language: en-US
Content-Type: multipart/signed; micalg=sha-256;
	protocol="application/pkcs7-signature"; boundary="=-mb39v9/Es4Q75I1QNApE"

--=-mb39v9/Es4Q75I1QNApE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-10 at 15:54 -0700, Sean Christopherson wrote:
> Part 1 of David's series to clean up the host-side mess of kvmclock.=C2=
=A0 The cut
> point in this version is still quite arbitrary, but what's left for "part=
 2"
> fits nicely into 2-3 buckets:
>=20
> =C2=A0 1: Masterclock overhaul
> =C2=A0 2. New uAPI and tests
>=20
> As mentioned elsewhere, my plan is to throw this into an unstable topic b=
ranch
> asap so it can be used as a base for part 2, but will target 7.4, not 7.3=
.=C2=A0 I
> won't publish it to kvm-x86/next until 7.3-rc1, to avoid polluting linux-=
next,
> and I'll rebase the whole thing on one of 7.3-rc1, 7.3-rc2, or an updated
> kvm/next.

Thanks.

I've rebased part2 on top of your part1 (and confirmed that you did
indeed pick from my unposted kvmclock8 branch and not the last posted
v7; thanks for that!).=C2=A0

To avoid introducing confusion, I'll try to build stuff as fixup
commits to be autosquashed, starting with that TSC offset thing and I
think I had some other Sashiko feedback to look at too...

--=-mb39v9/Es4Q75I1QNApE
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCDC0w
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhUwggT9oAMCAQICEFQru/eJkU7BxeS7T6sWKmYwDQYJKoZIhvcN
AQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNV
BAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBS
U0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMjQxMjE1MDAw
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
v3f7aa7zt+q39iASxA2NO0mYKtZdAAAAAAAA

--=-mb39v9/Es4Q75I1QNApE--

--===============0518466012104769306==
Content-Type: multipart/alternative; boundary="===============6605762467184628147=="
MIME-Version: 1.0
Content-Disposition: inline

--===============6605762467184628147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable




Amazon Development Centre (London) Ltd. Registered in England and Wales wit=
h registration number 04543232 with its registered office at 1 Principal Pl=
ace, Worship Street, London EC2A 2FA, United Kingdom.



--===============6605762467184628147==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<br><br><br>Amazon Development Centre (London) Ltd.Registered in England an=
d Wales with registration number 04543232 with its registered office at 1 P=
rincipal Place, Worship Street, London EC2A 2FA, United Kingdom.<br><br><br>

--===============6605762467184628147==--
--===============0518466012104769306==--
