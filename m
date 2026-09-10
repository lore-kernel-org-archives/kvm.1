Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D33E3166;
	Thu, 10 Sep 2026 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=3.64.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053114; cv=fail; b=a9WTfb7/cwfrBsTvXZqTK4z5FBEqC/8ut7p/n8h9eho+LDuPXwAI9Yi7kbl2vfORIByHGbPlS8YdGT8FYoEmxx4fFqmVPuI1nroJWpd3ND/G2VLYLPO6k4PUhKKWb2PmpdEDhnR5c8FxMgNbmsMAP4000OPVrl+oz7RjCkplz4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053114; c=relaxed/simple;
	bh=DuDcSHCajSGg/DRuRdwu22mUtg9t2YcJ5QO+hhVoWQU=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F0QtxJ2g/2EPmbwlRirc+IMZ9bawwgyb3xttgoKn4EKdiT3sW7BcssPs7xdjyKS+vsHzsjNWFgtmy9cgr+Q4gdkMZuCo/UrBOyTpThjfnXP/gJM/piYnzU5mYHmMKDWwtyg7OKDkVm3yOm51+jahdD8a8fVjafewPCZGw/2Tt+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=YvrU/uPD; arc=fail smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="YvrU/uPD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789053109; x=1820589109;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=DuDcSHCajSGg/DRuRdwu22mUtg9t2YcJ5QO+hhVoWQU=;
  b=YvrU/uPDH8RNZh4+/bhFHSBz6Fa8KGsj6GZL2QEVeZz+8pvT/IDG8YSY
   JksTnkMfHuS8fSxSMFsZKZoIMSPp88T7p78hrcl+LCzayz+63ZOYZu5pB
   CuIzYaxaRbkb4chn8VNyyRKrmOMnS3SByONWg2f1yDkcKjafBE2E2FUyJ
   WYIA6NEV4+k3/IF7Xo+zKv/K8uWEpW1gfSmuwjmVdxEjPQDIiPNZil08y
   02tj4HSyRdx+DVzd+saq9AKF6oGkMDQWaDwOvihwUYohtxof6y4IhzBG1
   BzzAeBeCSRc4uEk0kUIj6ch6J8Sgq+KHv7wzSUr8pq/krdxfrgObij/se
   w==;
X-CSE-ConnectionGUID: LD/T1VjOQSqqHBvDamA4wg==
X-CSE-MsgGUID: qmMZxeCXTQi9dg43wsEUPg==
X-IronPort-AV: E=Sophos;i="6.27,95,1787011200"; 
   d="scan'208";a="19228710"
Subject: Re: [PATCH v9 19/26] KVM: nVMX: Enable support for secondary VM exit controls
Thread-Topic: [PATCH v9 19/26] KVM: nVMX: Enable support for secondary VM exit controls
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:11:40 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:29383]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.16.222:2525] with esmtp (Farcaster)
 id c63ed880-c15a-4630-9433-692741ed8073; Thu, 10 Sep 2026 15:11:39 +0000 (UTC)
X-Farcaster-Flow-ID: c63ed880-c15a-4630-9433-692741ed8073
Received: from EX19EXOEUB001.ant.amazon.com (10.252.51.80) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Thu, 10 Sep 2026 15:11:39 +0000
Received: from EX19EXOEUB001.ant.amazon.com (10.252.51.80) by
 EX19EXOEUB001.ant.amazon.com (10.252.51.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Thu, 10 Sep 2026 15:11:39 +0000
Received: from FR5P281CU006.outbound.protection.outlook.com (10.252.51.199) by
 EX19EXOEUB001.ant.amazon.com (10.252.51.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 15:11:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sph7KdiXt/iICHMfXSZeeFHIV1by3FNqK66Edk3NXavJ+ux5kot9zLvfbA1C5TOfKsMll41oHeCPSq9MoRQrs7KW/D/2Z4A97ibAG7N5PWSzzZshTD43HapwvtPXR3ub4WfYZHwR4w3F1+AacaucYfjrOyGP6G3EscD4horNjYXF1ig4XvBpQZ7PSh3LlWfStYHK43nl8pJIuJD880AE6VMYgWZTkRRuFYti9b5yHYgpd95SrPJGUDZ30/Pav9yhTrWtZpt7WMiTvV3vWYPYlOG+yoifEZHPP3cm0xh+Gxh/jhQtiyCWKQHoiQMJeTucPTPaxwc6e7jzxJOKPidxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuDcSHCajSGg/DRuRdwu22mUtg9t2YcJ5QO+hhVoWQU=;
 b=M430rEePYo3u1d4FiGrqS/cLFT6cQdgVp+g29Wsx+UmvX0xNdwlHnnJmngZQaxSUAMQVzYclUUuKjCulqyWUDKABevHxb66VN7hGyBMFtjsWGHfcQvoXQqDbEubB1C2ZCG7ROYxzLJQbEOWFpLgs9TfFUDFcr80XTM/CXQgFnn1xC/rh6Et5mKR0dEkj4M246hS5+BXjAMVXStcHwTgNhPitdVtMZR+6sme2FoilVxvB2Xo67O+nhhlPJKdAAL0E7Ed4IeNypFz6KVifOJ3ah6V8w1VLTCN84XNMEZ53CV2Ou5cJGOnwsX0Ss3oDWYgHQWvYrE+YMvfcTR6H7vgiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from BE1P281MB2610.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:38::12)
 by FR2P281MB2960.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:69::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 15:11:36 +0000
Received: from BE1P281MB2610.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b607:8660:41ed:a2ce]) by BE1P281MB2610.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b607:8660:41ed:a2ce%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 15:11:36 +0000
From: "Ehlert, Emily" <ehemily@amazon.de>
To: Sohil Mehta <sohil.mehta@intel.com>, Sean Christopherson
	<seanjc@google.com>
CC: "xin@zytor.com" <xin@zytor.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "bp@alien8.de" <bp@alien8.de>,
	"chao.gao@intel.com" <chao.gao@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hch@infradead.org" <hch@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>
Thread-Index: AQHdOua9xJklk44Zi0+nlb+6/7cyzra7sdmAgAARbYCAAXZMgIAKvVNj
Date: Thu, 10 Sep 2026 15:11:36 +0000
Message-ID: <BE1P281MB2610D547AD0FBA709332702FBABF2@BE1P281MB2610.DEUP281.PROD.OUTLOOK.COM>
References: <20251026201911.505204-19-xin@zytor.com>
 <20260902142336.9955-1-ehemily@amazon.de>
 <649c7d7a-f042-4fe2-a3e8-eb15e4d76a46@intel.com>
 <apiL1WmN3j4ceDHI@google.com>
 <963e526f-0abf-4f8e-ad17-aa03809ea558@intel.com>
In-Reply-To: <963e526f-0abf-4f8e-ad17-aa03809ea558@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2610:EE_|FR2P281MB2960:EE_
x-ms-office365-filtering-correlation-id: 3eb4e96c-fb5f-4a72-0829-08df0f4dcec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|22082099003|18002099003|38070700021|11063799006|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: LTWmJUj4/7FrczrvP9Kzr8Ka2tZPGR5wuvl5VNBBljZGs2m+KFMEdA+OBMLnZM7CYdGRKT/oVgLBXN5p/amfe4dzyIrgo5ZMcA2tTyV4ziO/4XQ44kJf8GsF/2FEkLzJ1+kIlxVYOwXlFQ63nIP3PoJpqHqdzMrMCVLXFxP+VSy9UnjKqhFn5BjfZXJIUJ/T/Pvu8iwNWlVuiwHRRM0YW8XELaq0WgxqSSwYH/oq0Svwx1e780OuWPy1HcEiaOb/GSMynzlPJfiIdV2yZOSDkv8yOEEUjggpyfobWtFkRMuBMeYHSOrhZblReJg5ncAL+ueoG9N9GV/vql19bGVWCagnnwUNAHtPaHkhxNAITgdVDAh1nRM4FXKm6IYvk086wFkGAO+BGGXQ+mbtyBbVb9t37L1vteJtguI5WXXLXggd0+asSUCctUmOhv7P3Qm3TI4xT2zcGgHOowUQaT01e0wX3uWFzqflcjX/AAPL5ZlIAkjGepESVaXRTC3VvbpDY3WYTpSxBEAEPX8vdlEFeqqfHLflvPwFdZhR2tkKBDXrSWpkDbD6iKUP2Ic57IhGZBPF+RslT+kapExsHHprIm/FnCqvGcwusjBPkR02I+32PhVhZg7sf4TWlXf/WCL95YT2DILqiFb/48ZP08M3ZEjjxNhlAYThC+CjgtHVok+/SpXFLD8whQcO2AR9Ph6B1HhgVg7Q3XRam35wG2+2tQviExmP7Vx+W0gt0nwHgzA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2610.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aIXpj6J2hafyWjDHTHl08VFM1yHQwnC63uS+f3oh8A+p+5ELMjjDXdpDOp?=
 =?iso-8859-1?Q?E61esRv0GEmFN+gaxnPV64pokI4ailFGqU7OBBQEK/sWdPZXf5To7XyM5n?=
 =?iso-8859-1?Q?DsPRemXk4TyrU3aeGrAvc3I5FnjiJxw8gwWRt/5N6+Slh8inNcQ4iSET+D?=
 =?iso-8859-1?Q?GKA8b5xLVRofKdo7JRa8RiaiDUo6AmnyDfEmYeSSwIucEa1U4p88CKViZk?=
 =?iso-8859-1?Q?GuSIBjqrrdqsL65Q1p2n/G1IvmTiv4gr0X/m/tOCrJfKGbikIFfvF6cG0g?=
 =?iso-8859-1?Q?x+Otm0/AyfSddd5APadpvMbwB2kFp2rw1De+hfMuJ/oVQWuiwGBGooqWdq?=
 =?iso-8859-1?Q?e9C4jiuoF+3Jm/WegHmWwwhSXzLyOQHoEDLYHfDh9FZUBKfdoiqL90TmOA?=
 =?iso-8859-1?Q?JJwaJD4JpZ+kTk7zOp3CeX65x0JmW/Gxzs9fyunxZDxqE16UZok9fXy6Gl?=
 =?iso-8859-1?Q?jFPVTE9GftA1hXsvkF1HR5GfpDPcky+QoVL1kVtZqAaHeMNag6/4/JzMqG?=
 =?iso-8859-1?Q?6R96BXqPvDj8z9iVRW1YBeQ/4vqjFSeUXCqokBHksTypfRtbpfz4NpEvwY?=
 =?iso-8859-1?Q?8QuEiVdKC3BeRKNUTLuOWeORl0oFD7aJ3d3zuBXLUgHtsnCzOJfb6H06dm?=
 =?iso-8859-1?Q?O1JDVdrL7Nb60t/9DeutkckvJymUN5e0iA57XgF/F7jH8DHWRuhrLS2jmx?=
 =?iso-8859-1?Q?xzA40gmae/alheBvOAQQsCxV6jmVLjHxRAQUTFq/F35LqzSnL6p1SK6TNI?=
 =?iso-8859-1?Q?3z1WizvME+s4w2WxsxtuGEKHi2uxlIj110O8xgl4iXP5T165giKMq0NInd?=
 =?iso-8859-1?Q?jpizNQ+B7uuX9U7sIlt/QAJw/IynJIAVV4xewaLUEGQ2h/PxxjUbkYukkC?=
 =?iso-8859-1?Q?wp9cDxmoHNSi9SC8qEZkWwWlAxl+FzwGsJoTUWldrQo0HrNt3/r1Znw4Ft?=
 =?iso-8859-1?Q?Fx8N6nY7Y6+pe4I1C6/b99lBNMCgnlJcpHgSmsj1pmJlVyPPy2RIVnaqMb?=
 =?iso-8859-1?Q?+P5CejcjWqSdefjQmF+J8XXGQKbzij1JWv0aOdbjN8ufQ0BUl3QrkeumQu?=
 =?iso-8859-1?Q?5v9mcfshOV7bYHzTF7b+u8N/TfKDboMDslP0kF35u7lr2fGZaVn5Ugh9I4?=
 =?iso-8859-1?Q?m6WWZQOld6ZXBbpZ+JbapD5gwJbVEO4qgwLAwR2UdYFm+pcyyZp31JSqkZ?=
 =?iso-8859-1?Q?lyBS3OGl37vvroEtqkn6KlGOzz8KMFxLux4kv1g4fMgZlQ3Q9/MNGdo1S0?=
 =?iso-8859-1?Q?c0lh69MUkOSoepv6UKC3ZzUNNPlOez19RXAY/z2SVfXuuPypUlzxG6EcAL?=
 =?iso-8859-1?Q?BQCDMho8ZlrV7tNcO/a28EqIIK7mJxkifaMLtGAkWYiWsP21BydI2UFujA?=
 =?iso-8859-1?Q?dHJO2HI8WAFail1EybZ420wsTpT+4TjbfeVE7nMd78BTar63TRUKRJGLdF?=
 =?iso-8859-1?Q?FB/8uq0cOdRAznsYd7KgLEZqkBwVTZH6dVXY1okEz9XqJ0qItpatWzsi2Y?=
 =?iso-8859-1?Q?gBhskeNB8YgG3qmCWDepK6PyP8n3CxWADUTwB2NeD5TKRyxhNECOxeISO5?=
 =?iso-8859-1?Q?ExbhbjqP9KD2wkkPfJFM5+SHDRReN3bDiAtJC6Jj3dPCMjRuioTYDPw4Z6?=
 =?iso-8859-1?Q?NwfxRVUA910ZTl1jDGnGQAL87F+eScrmJrhmBM97c64d1XJveTBQHwVr7d?=
 =?iso-8859-1?Q?TFeYOQ5DJAczYHbFcXQ5e/Uxlk0Cs0xlmwxrDAbUuA39hnpDl2OibVNC0/?=
 =?iso-8859-1?Q?FvcOlLECx26XdIcGAS8eTMLx42sZU9HJm4UD2Z/k9bS0NY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T4vRIDBGiIN4XaypMgO0ZAncJgy28ELWmFQboU7ADfKFpk2HWjTUNm+RB5o+MfHznPDrcp21u3zWY5UFgT7FtAWfe6PWkuNTAeuVFl1Oo/xmot442g7R37nTZXm6sOzQBUGAWjeAvxDPW7RdOQkpWiudRYqsOZT+fYddfYbMF1B+xNvIgE0AOOQL6pBfsUhBIfBJ0OYbUA4WEo/ek992V4INrgFlxL4QXEVc3J9khGf3VBWZx2mtwrjcib0O9lvKuDqfoMlCuk6IFDpYsYRxE7tv1HDzcyZUnQxBwVauFNfkVSmxDaPovUmalHbrbWsnzt2cTlJVGRHI+J1nLrEUFQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2610.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb4e96c-fb5f-4a72-0829-08df0f4dcec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 15:11:36.5479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OmzHL78fTfEKgRwzj7T0lqJOUlQG4d+Wt2z9JYHH/UMQd2k2FW/m6xKcepN+NxL2umW1gLbq1vIcWc+jZpoaog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2960
X-OriginatorOrg: amazon.de

> Happy to not be the bottleneck here since this is FRED independent.=0A=
> Emily, do you want to pursue this given that you reported the original=0A=
> issue?=0A=
=0A=
Yes I would like to take this, just busy this week so will probably only=0A=
find time in a week or two :)=
