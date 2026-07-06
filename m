Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D514430318;
	Mon,  6 Jul 2026 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371686; cv=fail; b=mrvl2hDVpnkXbGZCPhCH1LxVZRUCVUv3aaoCFgV1XM5ChswkJklonA1Wb/gldjfqUr0RTGdJuVzdk0U8gSVduFyUs5khwQ4mmXm3e/H8qXzEPeWpN841FwDu8TXGJXiChlrtqe9KLPzbL/1CWN1KmOZvwmZ/HOoH5GAq/hbPq8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371686; c=relaxed/simple;
	bh=PphcuH+MUXt7emZ15wq14SsC648sPNApTGbakGvQq/A=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q2cp2mWK5QWZNCHbZCwE8jX28WJk4H3YoEzIOvGBJ9UPZG/5y4LvWti805pAABzL53j6rUzN82nN4XPzn217cSTzPogJgqwPafeIdCbiGs8fFEz2Nik+9AaY/QmHQApOJVtV4B4vxOt694pm9jN79DX4jBAmSUR5U5/0q6F7CU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIQQkK+3; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIQQkK+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783371683; x=1814907683;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=PphcuH+MUXt7emZ15wq14SsC648sPNApTGbakGvQq/A=;
  b=HIQQkK+32CGZSJWkQDXm+OoyKdp/4ANbEalNE8D8nc9S8z3Jr10WIVjA
   L/VuZ1hmX66FM3BdPF9l0wWeDV/Pve+YdHcZPBuofEGcUnlmkONde3NQ3
   b4JVILHH8F/eBc98w3Ey9wQzI2X2DkC7Q3Ewnqp2ZsO0gXxOXDpqOrTA1
   x0CL3pj3/puUh8zOUIItJCZmC+ucGRf7xBth9uTrzgC+yOmXbtz88yiKO
   DR0/t8tjZtD6/ZLjjdafg14LhuVUO2IR+pgxmLVwrrssnU0qiTtG3hayF
   3irBGdjzbgNT56PRJxNAL3eJDHqsnrS6c3d88t4YCod2qhlnAJpvfjCZM
   g==;
X-CSE-ConnectionGUID: MlLRvAxOSKyH0XyqMjqrsQ==
X-CSE-MsgGUID: rkUM33utRzyqAgxusPmwQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="83876350"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="83876350"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 14:01:21 -0700
X-CSE-ConnectionGUID: 9Vf7GKQyTTO0f/fHuGgm8Q==
X-CSE-MsgGUID: OPf620GpS2Cz86jEMtvAMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="254462519"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 14:01:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 14:01:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 14:01:21 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.6) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 14:01:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFzeSGXV29qCO9QshVqaWT81gzXy9KUswO7Zr89dzZL4WxCeZ3kKnDEs9lr0kaTnkkxR3uIPvu+6EUgAXqEK1lWEUjtU4G2HM3l9YBWOgeZGyUoEKZElNCsxQeg2muETJ0YXnAf8H3iAOHhWm6hoMrRBSpnmHiwDR9JvrLsRLBTHwMxoGK3/tt7rEJp6TjcvYUIyf1nZJferKXAKnjUnkknzsIdUza9i7MGHS4hbaMKO/793Mg4g0le7SUEPfPYtqBB5q47J4pWxYHqUzX2gIn1LyU7zMNSElwvYd/6XKOAT5rX8o8nht/N5+v9e0XYBw2tPQqlJ+z5tDUg8K7TVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PphcuH+MUXt7emZ15wq14SsC648sPNApTGbakGvQq/A=;
 b=TgvAl+ERZRytWfsvBmSN3cBf+utYMEcCSsK7zA9qVoC81BGnsl9zYeWq5Ee2dLmab8xRd6gw79AZdaEx7qXYRByGFtuXU3imhcIYQb4gAar1CylB/fZm13cmpbsSu5/9lKMMYEY7e8/n7lZu0TCQlWDXXlQZZMnkjuT98J4JIBZG3T3Y9oEYVUOcBsy2wFcy2xTZlpualc87PUWaPY5B1pKukhNudEtGwg0M18w4Hn2sroHlC8TlDprPQ2HeAMN1NDodKIqr1ialqtpZNYaDIE8/NNG7m3VUecULDloLnSk4KdqyZNZssUzIrT0ZV0aspAcqgsQl5ts3iY2IRb8w9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by BL4PR11MB8845.namprd11.prod.outlook.com (2603:10b6:208:5aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 21:01:15 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 21:01:15 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 00/11] Dynamic PAMT
Thread-Topic: [PATCH v6 00/11] Dynamic PAMT
Thread-Index: AQHc7Lharxh55RbAGkSefZRzihMYJbZhO7eA
Date: Mon, 6 Jul 2026 21:01:15 +0000
Message-ID: <f2b2a3a048ad6429305e0e21319a8c27bedf39db.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|BL4PR11MB8845:EE_
x-ms-office365-filtering-correlation-id: 89c4dbff-f973-4236-a03e-08dedba1b7e4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|11063799006|38070700021|921020|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: A+RhWGkD/u68N5TSNF71DecSyNw92QUQCWuBgZYjZ4aRBpqrLjFMNyqDOWOOp813g7TqjfD1kfMWlMu46J/f7Da1Jc5jyROAa0tEI94IbmLWoNybnzJAvGtSpFwEvYBroAbCV0j4BS5DhwJQADs++zsjYQ6LMTJ60G4j53bHMm7QBO22dBAKzCCUbRFoGCbnktuO1lbb/+EzeVxZnIprpzxHkrb7JVMnknxYA1rSmgUHo5OomqbrVuUjI7+4LYkCVrrbomjWb+9ITZoxU6vJBNfG5nXnEN9p0Z+NzuqxA3ib5AATqJRqRVRg+I/sYBA0foetTtvUyN8AzsrPrVQRx5NNSTGFS328B2K7lTRp9zi0V1IJONcEyK+kaIkdcR99QeYJPB01GgdjuaO4uux9RSc3HNAY6Z+M/v3LOlCQFgJ5zyLuN8JW17mpHvHFh17UlnCCzlvEspMksju+Il2usZXeISxEC3TL+k7dMyrQrIeIYG3AnHjCAa2WT5IDZwJPTZZ7jiI2BZAVcqgd8oWS+fxKhyyoURZ5JcmXz60zLWMBSS+VF4asHIt/eobQpGz5/cyf9ifEEjOwI88SmbPJ1/yQ9kIpBmxvwFpz9R5OZrsytrJGej57Cy1GAiE5QYMDSf+yw3EqnEc4eXlpSGErx9Imo9kILgqd3KhBJrRduCbwsbl2e7K09ae5HL4S4RZEcRllrSpmYFmSiuIbVR/kCJL/q6W1y6QB8PWI/OQer0w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(11063799006)(38070700021)(921020)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGtEdnpkZlV1MFFWQ1pROUhER2pYYllTc0ZBWU9ydTZWbW1JemxQZXd0WUx3?=
 =?utf-8?B?YmRKODBZbCt6ZDkzaTR5cUJoUU5FY0trNkJ0RStpTktGNVMxRFJkUEMvV1ZI?=
 =?utf-8?B?VmY1WWV5VmdBZXhhL0wwNUVCWmd2ZTVhYVA2dmNpTlhrc05CNS9IRzdhWWFW?=
 =?utf-8?B?ZkZOZGJnaHN1SUNoNllZZWlWbUpjWmtLbzdsTTRTZnFtVmJybTBCRmRNOGJ2?=
 =?utf-8?B?S2FVVjUyclV0UThRMmE2M2VqZmxMdzNxVFJLYWN3eHhBYzFBcWRIZ2N0Qys4?=
 =?utf-8?B?NVU3Ry9oZ2tDRFF5QWwzeWk1YlVnNmxLenBaYjlhMmQwcWRuUE1JU0tCVEQx?=
 =?utf-8?B?L0pSaVowR3dXVG1USG5WcTdzYlFKSlNTUUNaczBqbGtQSVlPMmo4UDVKUVVo?=
 =?utf-8?B?SGl5U2RoYm9ET0dkeGg1SjRiOVVUSHA1REZyWFB5MFg1NzgxdGZTaFdReFkx?=
 =?utf-8?B?c29vY2ZFZTI5bmNmQ0luUFhHVU1EdWJFc3Ric0Z5eDJ6Y1U1R3M0RlBpYklV?=
 =?utf-8?B?V0VtS0lzVFVqVXkyYWVVV21xSGxQMERKN3Z5ZDRjdjlvZzBMVkliZkY0RXRr?=
 =?utf-8?B?bHZEdzNsdGg5aG45Szl5SGFxYlhDeThXNjQzNmZTM3ZPbFU2OHlIcnNXUmhH?=
 =?utf-8?B?dkhka0FjVHVnR01OaXVCS05aYStqV205WG5yU2U1R21sOGZwbEQzQkdvQVJP?=
 =?utf-8?B?OW5XZHA1MXQrVVZVbG9SMWlZOWplcEE5aDBrdmRibVJWSjN3VnZNcWtvSy9T?=
 =?utf-8?B?ajg0UEZQZ0RVUDAwUjlHV0pWRGdKQ1RhSldnTndlSEJXTnNPWDBQRWV1dWpS?=
 =?utf-8?B?cjVMSldtTlNFMzROcWRPeFFCRWlTdVJmTFFpbTcrZkxLejhkWDkvaHJmZHQy?=
 =?utf-8?B?ZDZ1V3lwK21lSWVwUjdNUjZqNVAzdVZWNEZpS3RVelZQNDI0bVoreG5iMmRK?=
 =?utf-8?B?Zkh6Mmd5dTg4MFJFZkt1UHJ0QkhSWjdjNlpsQW51UURqZWZyalYzQTMrc1pS?=
 =?utf-8?B?RDVSS0t4MkpYV2JubzNBRDB5emI5SHZMVFlzOUhNRVl3Q0lkdkc1Nzc3a21y?=
 =?utf-8?B?NTBaT3hiVldGMjVxVllJVnlGMjFxdnBsYTdZbVNBeUx0T2lnN0pYcjVqaWZK?=
 =?utf-8?B?SnRyWlU5WmYxZ1JPU1l4QjZOK05ZSEFTQk44eExpMytLQTQxR3FnUGtzVlRv?=
 =?utf-8?B?dUMyd28wMGFoT2hBMFBPaGtMWTF0cnUxNzVUck83elJpZzFsOUlVT2RCdE95?=
 =?utf-8?B?R1I4SUpJaTVwdSs0REhCWGs1UzNEeXFVUzJoNkxYRlR3QndGQnlvNHkvQkI2?=
 =?utf-8?B?bnRwYkRZT0U0eUNiUk1hbFhYSms5eklDb2w4UGwxQzR0RWdVeUZjV05YVU5G?=
 =?utf-8?B?bEFWLzhWUGNkd2JHa0E1b1dTdlFuTnA1RTFha1d0NklReUJkeXdkdU93cnZK?=
 =?utf-8?B?cC9OZVp2WWdqMS80UldkT0xJZkx0dC9MOTJ3ZjM1ajZUTm90RStzUjBNemQ3?=
 =?utf-8?B?b2VOeHQ4VHdDaXF1SFpRYkkzK2grYnZPR1dQZ3hzVXhqU1BUZHVyb2JvR0J6?=
 =?utf-8?B?Qjk0aGNpS2xRTmJ1bEdnNWlnNWhQVDYxSE50dThJbFY3eXhCYXZ1SXlhd3lO?=
 =?utf-8?B?TUd0NGloaHZqNXR5ZnUyTG5VV1lBYlYrL1d3NmpVZjVNcVhmaEo3TlB3YVZZ?=
 =?utf-8?B?SEtNcjhhelk2NlVqQ3pPR3FvVjZpcWNrQkpSamtsV2YrUTdEV3l6Q2Fxc1lS?=
 =?utf-8?B?d2ZwempNelVQVW9sY1pneXhWVmROaHBkdTdqM0d4SmtFRWNnWlNpc29aSGtT?=
 =?utf-8?B?ZmF0eGUvblVrZ05uRDgzNGJKZ3hQUWVNUmcySU5pNlR0elpiQVl3bEg1aTc4?=
 =?utf-8?B?bndGRm9UYWxZbVpncGVuRkUzaVV0YTJibkhwRERtbHdXcS9nengraFZQV1FI?=
 =?utf-8?B?NnF1QW9DUU84V3RDWjhybmpTZFhmOEpUUEdhaXhhVWU1SE9wZXNqWWU1Vjdk?=
 =?utf-8?B?anhvTnNmRWJIc0w4S3FtN0VVTkdxUWNRVWVzSlFPWG1yVE5Qc1Y3L1kyL1Nz?=
 =?utf-8?B?Q1lXWFcrK2huU2hSRk5NTGZwOVpLYjlrZjA2NWlRVDNQTFlYUFRpdXpCZWxu?=
 =?utf-8?B?aVUrNjJBbHdjdWdvZUtEZ29OTW14Rlp5eVdIM3M3bjBvQlIxc05BOFZ5bHcy?=
 =?utf-8?B?alhiVE0xOHdKQ2kwTjhPeWM4ZmZvZW56L2FrTkNkdlU4NUtQZ0JZRmlqTXFs?=
 =?utf-8?B?ejA4cnlzZEY1MVAxVzZqa3o5MGRmWldFclFtYnYySXJCQzR3UUxaWVdJUmwr?=
 =?utf-8?B?VlFrb3YvbGxTLzVCOHc4a2UyTXdtVnVsOEVsbVBGZXphNDdTYTcxaHFnR2ht?=
 =?utf-8?Q?YMdBi+G+0HvwvHdI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2360F2F80084064CB8FFBA29593FCCDE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BBwxA9PpSBg6uRBjYP+bhVl4rXFOEh+QJK2p3EwUFLzWkzd9Tmrgu3VNtQArKLlxZrr3KSj5ljKocHzb5143nifrOWUYkSaj6m4cQAceNJ00F1+cL/XIpF7iU6cEgeIjyAK/371gd2m4cS+yLeSMujmn2TBb5y3uG+EjqRaUwH6FXB9g2vOebIDYONkD1d2JxcozJDcDCpR4o3Yg33d9atif6dUaEM44dEQ4IQB3cqoJ/+Wguj4IcQNmCIkbAoAp5rp3/QhFjn24p+h3xXXmF8Lfu+IBmND+HFjjdYAr/uW2Dj4xQyEkjVn5jbJu7AxRW252NYeJk46Wy9G9wYdSLw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c4dbff-f973-4236-a03e-08dedba1b7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 21:01:15.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMS9/J5WnmlI1QHv2EggfWJDLkehwcfDumV4LEcrzXLhc/1axHDbCNZZHTgU4UUX0Tj93UeZm6UJuHL5fa4TOmk09tkB4drA9ilQpS3mQ6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8845
X-OriginatorOrg: intel.com

U2VhbiwNCg0KT24gTW9uLCAyMDI2LTA1LTI1IGF0IDE5OjM1IC0wNzAwLCBSaWNrIEVkZ2Vjb21i
ZSB3cm90ZToNCj4gwqAgS1ZNOiBURFg6IEFsbG9jYXRlIFBBTVQgbWVtb3J5IGZvciBURCBhbmQg
dkNQVSBjb250cm9sIHN0cnVjdHVyZXMNCj4gwqAgS1ZNOiBURFg6IEdldC9wdXQgUEFNVCBwYWdl
cyB3aGVuICh1biltYXBwaW5nIHByaXZhdGUgbWVtb3J5DQoNCldvdWxkIHlvdSBiZSB3aWxsaW5n
IHRvIHRha2UgYSBsb29rIGF0IHRoZXNlIHR3byBwYXRjaGVzIHRoYXQgbmVlZCBhY2sncyBmcm9t
DQp0aGUgS1ZNIHNpZGU/IEknbSBob3BpbmcgdG8gbWFrZSB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRo
aXMgdGhlIGxhc3Qgb25lLiBTbyBpdA0Kd291bGQgYmUgZ3JlYXQgdG8gZ2V0IGFueSByZW1haW5p
bmcgY29tbWVudHMgYmVmb3JlIHRoZW4uDQoNClRoYW5rcy4NCg==
