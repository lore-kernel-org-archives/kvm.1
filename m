Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095FF370ADB;
	Fri, 28 Aug 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936305; cv=fail; b=Ou73810nNs8vvjLCMDXMKSXXvfpv3cepOQwA9QpBC2mBaXmElBWmiJ9eow/NGdv1+lhzZFz7HcDH+iah9SEhA3GimI1eIwFv5QWwrGFPyci5mw3FgKAI14GVOXiIZ+90W7N2oqRX3uwtEeEyVqj/jOOcR3pS52UXlxJWRoIxujg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936305; c=relaxed/simple;
	bh=kfQeKEfTphKpH2A4vvVS1nLgjwMTy2yHr9RDYvBoAnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XLJY7aV9bchcYWzpad0eLMfxAe2w9e1Fu9ZGzzrR5XuRkfD0gJy+oHc4pP0ea7t7a5iqdLxlFT2baTXR6mSWaQZtlpRUjOtHIMZIvn+zQoiVVfqvNJh+edV3AYfFcFlG6299vTGKeuTghP8LRKBdcVzfhgLTHCMcZ+FRiv1205A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqCgcNxi; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqCgcNxi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787936303; x=1819472303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kfQeKEfTphKpH2A4vvVS1nLgjwMTy2yHr9RDYvBoAnc=;
  b=DqCgcNxiakdb5mBg55vza65QMVXexClTYrP+Q405kMBDGPO086vnoGif
   CuAQchEH+HtDRgICkRIf5IerWd8IUkwd/+pOzMw2Xwk+lSwvSXRYOcoo+
   8NHw6noXiRGfUBDkQ9meKXfN/rJN10vC3lze0Sr+2aimKVR6dIoSsyoqp
   007htF+G9bZIs8/3VxDQ6ak5J4Z2Wd+URB00VkT1RBidvV1T5/fmi1IcI
   HQwNOyZEzemwdIClQbsH5MoHlkKMCYnUPEGyGDQzi1z5BnQhpJleoro54
   /bk+zGzYi+zKdustXiOkMbsVf4PbkodITeOhrT7RJvbXuyK9w8iZQa+gk
   A==;
X-CSE-ConnectionGUID: PU0kvGHgQ7qw8Jt8F8t0ng==
X-CSE-MsgGUID: 5+lrn2EURfe//D9ZbiI8gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="99798147"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="99798147"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 09:58:20 -0700
X-CSE-ConnectionGUID: mNl3BZg0R2eyWoPNR4qi9g==
X-CSE-MsgGUID: tG+HaJ4XTFSfdJXhtbjU0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="270155209"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 09:58:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:58:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 09:58:19 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzv647VrhLI3jNj3wO6f83R359h7W6KmLGdeSvDSlNbrYqB//jub2n7YhRudAh+Qd/LTXAORCeXkG4bbPuZ4K2X1Is69yMPKis9k497TbUpWOVg5ZIQpLil+K6JP8jLlzHLY23ZsOsrVGv8ASKkd0RAc2zFS+qgYbBFIP/yZC17TGPFv+NSsOc6eM7jjKEg6KqbMsny1XT2E+HC/dFqpgbZP2r3fKRuS4zN+5dED+Pm8llXQn0mF/It0fzzn7kvGZ+Ir6YS6xUzBCuBtGeAQt8UjndKe05pskaq1SSHmN3Bqr/sZHSdQC1Ktscf9LMCLTZUVHR2Wsg+GVIG6rbHFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfQeKEfTphKpH2A4vvVS1nLgjwMTy2yHr9RDYvBoAnc=;
 b=xRjXkcaAaHsLMdXfjO6OjO6GT/Y477yfWQDXn2V+zrCbhFpzXFRwd4wp7uUTUYnWH173xt2gjDicTNVl4M9Xl92H4ZN1R8ZmO0gORCvOn4PRumBfj0tAGEKh6GR5UeedDlGWoLRiBE/QRRLNReuBdOxGgGajxuSAbtiahL2WJ1BLC4XH3WiPq47xkSnCTAxuPDR0+1Aog+smlfmdGApGU1hphuaidT1/OTzAYU0rRMNvEAl5NUoGcgM1XCnCDc7KKXkKpHwdRIGTa4sjrOr0dxUAyIjzm0NPcZe58iVMIHhFew2ux2pY6+gX0hObw3Z/+mWUp4BRnuPIWwyK5Wk6ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB6906.namprd11.prod.outlook.com (2603:10b6:510:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 16:58:11 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0360.006; Fri, 28 Aug 2026
 16:58:10 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
CC: "Gao, Chao" <chao.gao@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Topic: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
Thread-Index: AQHdNdIhqH6lArRWVEmiaZbi1C7mgLaySiAAgACCPACAAOTNgA==
Date: Fri, 28 Aug 2026 16:58:10 +0000
Message-ID: <1deddc78d14326b378ddd62ad99c21d66da401e6.camel@intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
	 <e2f8f7976ac6a54e0bbda0e65ed9990940d9fef3.camel@intel.com>
	 <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
In-Reply-To: <d2efe512-e4fe-407f-96a8-b274fef23382@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB6906:EE_
x-ms-office365-filtering-correlation-id: 9070bfbf-8ddc-4fcc-282d-08df05258ab2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|18002099003|22082099003|6133799003|4143699003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: ITI62uvIHRhM1QGs/qUzS3V4SwzqTzqZIP9CdHNEAmMYmt0LrgLFbcqS0bZfA+JkgZFVhYdeKk2d2GVa+XaoWR7NJnOVb36Vj6N/wcdGNPWUEhq0/0+Nx+QGpMrm7338GMYloo0x1si8JMeoD5TvYIKRGm3LKnDXd2LpleeBQcDZ5jEDCwFrmlDWfk1ZAZamv7hzThuCAMGWF0oVeMoBqwiXaqW9czYvsHyV9cCDNVq4vLpMgSGMrMtjkV0Grp7n/rFvRPE+ZAda/8blKvAejtRWbPqv3kFOxGRdIgKRPu4LmqzWkLYKORIe50l7Uuc//Bzec9JkdvnXQn9iu56bzRF1sNLHwAbPB/hunCe6/6aUuNQWdtxsvSnG3H6NZZSoOoLezgcwS5tkxdW8sS/aKsQf2Y20cVXt77wSmt6VqB+NGq2NbuZwsQ+ZgpVjbXsQmVQog0Zf8akptf9704a8KHi/zjqkDm54HgaqDwVGH578K8HZgVatfwQzV5PkJ29exdpqa8DJNNdxCj7B73j0PGLBDsD/Rlqf6703LxSn6GRO+eJG6McXEAvpOHWQVDYeaHpB56kTfaJ5vTG3VixpCFlZ1DFSHsiGGVehoDpqNouNdWNu9Np+a0MoT/LWDevnR8MrMTmLG9l5LhEW4wBphfwxayPqS1EMs7EaGzli/tFNlplM7xazCz0WH76b+KlMYcrxN8ZLkk38bSATt7UH0wLZa/UeH38D+2OB1TciJO8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(6133799003)(4143699003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzlYMlJlK3Q2WFA0Mk9HRXlleGo2bVhReitoQlphZEdRRnU5SG9zWVRoaFQy?=
 =?utf-8?B?NFRkdEFzbVhzUjgyMno4K0k3OVRYMS93d0FTM3lnMkRkNFJkRVpKQVM5RC9F?=
 =?utf-8?B?clNpcUVQUjdWVGk1bjltRnRwOTl3Q1lEbGp1c2J5RW5iZ0RranZra0xIZUlE?=
 =?utf-8?B?NExXWjk1N3ZDM0ZLNmZCdWxmZWw1SjdFNlFwOEFTcWJYM0dDS3JCMXRvam1R?=
 =?utf-8?B?QndRQ3RwMDc0dGFoQ2ppcmxqcWtZbUN4UTdldGFOVVFTVUFLTVFFTjVtRzAr?=
 =?utf-8?B?Z2I0S09EU2tnVTJsTUhaZkIraFdKNlB6VitCRWJlT2ZLa2t3T2l6cUw0SG1n?=
 =?utf-8?B?Y0tpTE1WOElyb0V3Z1AydkpnSWduMTU3OGxHTE1XNWVrK3hUbXQ5N0tFOVVQ?=
 =?utf-8?B?V0FCcFNNK0JNbWpXaFI4K0V4REcrR2RsdStGTUZqT2pRdHBQNGI2dFhaaWRu?=
 =?utf-8?B?b2pNNVh4d3IyU3d6eUhqUUJ0bk82dy9TSTZLTEJZNjhrajh0dHlDdi9SOHBp?=
 =?utf-8?B?V2FkRGJZL1lHSHB4MCtXV2F0dWlsYnI2WFBCK2FYdmNNQ0Z2L3Y4NXcrRnNW?=
 =?utf-8?B?K2ZNMVBkbDlXK0tlWStPejIxVWZvK2FWaDFzUE43ZjcyTFFYcSswajVxbW1W?=
 =?utf-8?B?aGVndGZjZWVIV1laYWE0eFl6UHhYdFlvVG1pcVBpbjBUbkpjV3dvOGwrekxM?=
 =?utf-8?B?dU9ud29SRXlLQ256QU8rbXE0dWZrU01TNXlGK1huUWFjRFNuUjZBSE1TanFr?=
 =?utf-8?B?dzYrMnQ2OVhuaFZWcFNPL3NvRll4blNpcEdYcXJLMTdkZXNYa0JoRGkyNkJL?=
 =?utf-8?B?K3l4T1NwaEgybEtHMjM3S1Y0eUc1Y2RZNHA1SXJ3TWdzZTJXdThXWUhPYnFN?=
 =?utf-8?B?L0J4WkhMeCtOOFJtM3RvcWMzNVNPaWZ2b242ZTRSUUIzaWxoUWJvYnNFbDNn?=
 =?utf-8?B?WEh1T3JhT2t4WXI2cUlMeHdFbVJZeWZaTEZHWTM5VzZvSmgweUxvVkxML1Z3?=
 =?utf-8?B?RkJkdmx4dGN1bUxmQmIwd0NqTlU3aElwbjhtejZ2VEhWR1JmKzdwc21la3Vt?=
 =?utf-8?B?LzNrUkd4ZkhjaW0way8wckhMTS9KaFBLL3QxcFVRTjdNaVQwQmZNTXJTMnFE?=
 =?utf-8?B?cUJScDJJazltOVpxOUtEUVpGY28wK2d2dWlZblJzZVExNXpycmVHOU9ZTnJ1?=
 =?utf-8?B?RDZPVjhJSkQ3RUg2REV0bmxNQmFQQnRhL0pvcW9zQmhRTFdvRzAxSXk4aWor?=
 =?utf-8?B?RWRZa3NOcUxPSUJmcExhNGpTWGtTb0lUQVhETFpvdDluZUNuc3BKaXpYTVg5?=
 =?utf-8?B?My9KVGtMUFhQTHNLNjFwUWNoYUEzeVROcXd2S1JrM3ZvaC81em9pZmxCZmZB?=
 =?utf-8?B?OWJJM0ZoakFScEN0dE5pRjJoclh3NFVRZGk0eTRPYjAwN3RoNStleEJpOXM0?=
 =?utf-8?B?dzNwR2Ezdjk4TU12SGs5bHZ1RW9FM004LzdkNFhwb1hyT0tmRXI4VGZHM0Y5?=
 =?utf-8?B?Rm9ZWm9WSHVUOEg1cGNqWnFaZkxaeDVEUEtpRHN5bUVqT0tmaHYwS1Fmb1Aw?=
 =?utf-8?B?NjJKcjZKS25vQ3pRQjVXVGlVWmVlV0t2NkhMTy9Rc0NVNGRaZWJ1YWluSlRy?=
 =?utf-8?B?QThqaVlHQVBFMlBTUkdNdGVMdnlkOXlKY0ZlcFBUdzlsN0N3dThvTUd6TXNk?=
 =?utf-8?B?ZjdUS1g4cWpRZ3gzR1N3ZTY3R0hjRkF6bVNvRkVUckdBRU9CaHY4alhwZHlZ?=
 =?utf-8?B?U1A4Y0lkaXFBK2dycERhVnhpSzdkWk5ScVlTUnlOREVjMk5tTjloNU0rVVg2?=
 =?utf-8?B?RnNxaU5lUmtCK3hYMUdhb1VWR2RreEROanMzMk94U3JHcmkzV1M2V05ONGNx?=
 =?utf-8?B?UEpydGJYN3phNEh2bk1zZWlRNmpFUTNRbm5Ob04wemZXaG5mbzEwV1QvWk5O?=
 =?utf-8?B?bWJxRWJRNHVVTDBnL3M4SjROZGFWR1dKNGRZWHdoWTFMOGFmTXY2M0ZRN1Qx?=
 =?utf-8?B?WGlGeDN4MkNONVVUTDB5blV1dVY0UVpZRkpiaHJvMnlnM0JKY2d5bS83Q1Vu?=
 =?utf-8?B?KzBlRTN5M083dGw3SDRFQVIxRHFDaERGWldvdUFzMk9yaitYK3dvTThPUmFU?=
 =?utf-8?B?QiszbWhlczNPZmNqaXhNaEttZi9uajhoUDdMMnBrNHY3M0gvZS9rKzRYcUEr?=
 =?utf-8?B?aWZ5UVZxaXRwVzk0Zk81NHA0ekJlRkFWNTRtb1g0KzZwMmdlTndLUnZ5TzBU?=
 =?utf-8?B?ZFFZUG5Vb01SZE1rS3Q3ZHovU3JpMFNhNWdjbTA0ZmpkMzg0cURtN2FyRzdo?=
 =?utf-8?B?dHpYUnRZU1p3bVVlOXFHQzFXb0h0aXZZYXJlZmFyZWVhNGZXNEg3TXJDYVpF?=
 =?utf-8?Q?nXxDUcxUUIyMRUdE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D9ABF51800D9849B3334011219D1853@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xlzQXFwE+qRuaiCtA4gx86giznHi9FSnJcBiZ1KN58Y5GNh4TdolFs089vAr4TKlx4YfWHQNmUIWEVpdge37GYMXKVZTVFyJMGuSzUqu8g6pjd+KxnkpY8D5j5zg1mO9d0bF2q+I0tZtRFnGGzXayLNGcHRN5ua4bvWVBLYM/GqJafDQb+qjRsLvxixSgQpXD9wGMs5UIAb74t32t74RBsnbbhUKmpjk5ogpgGyLH3mwFS/77UKKm6upSrto0HzRoBZm5ji+ihBGK0aSqFHQETOFNEQt9z8y3a0ZpjYkSiGVV9D2COywLShBpACRAyCfaC7I+CPH6NgnGokreWADJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9070bfbf-8ddc-4fcc-282d-08df05258ab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 16:58:10.8174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XT9TzlgS6/pGkIhYi5DKpDX8O33V36CpF0xcPl2thlWp95HS3af48RhLMgAMAjKglvC3bk1RSDoV1aGuwMZYiWMHxnQAlR2vS0q3Aadt/x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6906
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA4LTI4IGF0IDExOjE5ICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+ID4g
DQo+ID4gQnV0IGl0IGlzbid0IGEga2VybmVsIGJ1Zywgc28gSSdkIHRoaW5rIHRvIHB1bnQgb24g
dGhpcyBhbmQgbGV0IFREWCBtb2R1bGUNCj4gPiBmaWd1cmUgb3V0IGEgc29sdXRpb24gaWYvd2hl
biB0aGUgdGltZSBjb21lcy4gUHJvYmFibHkgdmFyaW91cyBvcHQtaW4ga25vYnMNCj4gPiB0byBh
bGxvdyBmb3Igd29ya2luZyBhcm91bmQgaXQuDQo+IA0KPiBEbyB5b3UgbWVhbiBvbiB0aGUgb2xk
IHBsYXRmb3JtcywgdGhlIGFjY29yZGluZyBURFggbW9kdWxlIHZlcnNpb25zIGFkZCBvcHQtaW4N
Cj4ga25vYnMgdG8gYWxsb3cgdGhlICJlZmZlY3RpdmUgMSAtPiBkaXJlY3RseSBjb25maWd1cmFi
bGUiIGNoYW5nZT8NCg0KWWVhLiBPciB0aGUgb3RoZXIgd2F5LiBGb3JjaW5nIHRoZSBvbGQgZml4
ZWQtMSBiaXRzIHRvIDEgYXV0b21hdGljYWxseS4gQ291bGQgYmUNCmxpa2UgYSBxdWlyayBsaWtl
IGNvbmZpZyB0aGluZy4gVXNlci9hZG1pbiBjYW4gZGVjaWRlIGlmIHRoZXkgd2FudCBtaWdyYXRp
b24NCmZsZXhpYmxlIGRlc2lnbiwgb3IgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkgZm9yIGV4aXN0
aW5nIFREcy4gQlVULCB3ZSBjb3VsZCB3b3JrDQpvdXQgdGhlIGRldGFpbHMgbGF0ZXIgaWYgd2Ug
dGhpbmsgd2UgaGF2ZSBvcHRpb25zLg0KDQpJIHRoaW5rIEkndmUgY29udmluY2VkIG15c2VsZiB3
ZSBoYXZlIG9wdGlvbnMgYW5kIGNhbiBjbG9zZSB0aGlzIG9uZS4gQWdyZWVkPw0KDQo8c25pcD4N
Cj4gDQo+IA0KPiBJZiBGUkVEIHN1cHBvcnQgbGFuZHMgaW4gS1ZNIGZvciBub24tVERYIFZNcyBi
ZWZvcmUgdGhpcw0KPiBmaWx0ZXJpbmcvaW52YWxpZGF0aW9uIGlzIGluIHBsYWNlLCBhZGRpbmcg
RlJFRCB0byB0aGUgaGFyZGNvZGVkIGRlbnlsaXN0DQo+IHdvdWxkIHdvcmsgYXMgYSB0ZW1wb3Jh
cnkgc29sdXRpb24uDQoNClRoaXMgY291bGQgZWFzaWx5IGhhcHBlbi4NCg0KPiANCj4gQnV0IHRo
YXQgb25seSBob2xkcyBmb3IgYSB3ZWxsLWJlaGF2ZWQgdXNlcnNwYWNlIFZNTS4gUUVNVSwgZm9y
IGV4YW1wbGUsIG9ubHkNCj4gZW5hYmxlcyBmZWF0dXJlcyBzdXBwb3J0ZWQgYnkgYm90aCBLVk0g
YW5kIFREWCwgc28gaWYgRlJFRCBpc24ndCBzdXBwb3J0ZWQgaW4NCj4gS1ZNIGZvciBub24tVERY
IFZNcywgUUVNVSB3b24ndCBlbmFibGUgaXQgZm9yIFREWCBlaXRoZXIuDQo+IA0KPiBBIG1hbGlj
aW91cyB1c2Vyc3BhY2UgVk1NLCBob3dldmVyLCBjYW4gc2V0IGEgZmVhdHVyZSByZWdhcmRsZXNz
IG9mIEtWTSdzDQo+IHJlcG9ydGVkIENQVSBjYXBhYmlsaXRpZXMsIGFuZCBjb3VsZCBzdGlsbCBj
YXVzZSB0cm91YmxlLg0KDQpSaWdodC4gSXQgdGhlIHByb2JsZW0gSSB0aG91Z2h0IHdlIHdvdWxk
IG5lZWQgYW4gb3B0LWluIHRvIGF2b2lkLg0KDQo+IA0KPiA+IERvIHdlIHdhbnQgaXQ/IFdoZXJl
IHdvdWxkIGl0IGdldCBwbHVnZ2VkIGluPw0KPiANCj4gU28gaWYgdGhlIGFwcHJvYWNoIGluIHRo
aXMgc2VyaWVzIGlzIHRha2VuLCBJIHRoaW5rIHdlIHN0aWxsIG5lZWQgc3VjaCBhbiBvcHQtDQo+
IGluIGludGVyZmFjZSB0byB0ZWxsIHRoZSBURFggbW9kdWxlIHRoYXQgdGhlIFZNTSBpcyBub3cg
ZmlsdGVyaW5nIHRoZSBDUFVJRA0KPiBiaXRzIHNvIHRoYXQgdGhlIFREWCBtb2R1bGUga25vd3Mg
dGhhdCBpdCdzIHNhZmUgdG8gcmVwb3J0IG5ldyBob3N0IHN0YXRlDQo+IGNsb2JiZXJpbmcgZmVh
dHVyZXMuDQoNClllcC4gQ2FuIHdlIHRoaW5rIGFib3V0IHdoYXQgaXQgd291bGQgbG9vayBsaWtl
PyBFYXNpZXN0IHdvdWxkIGJlIGEgYml0IHBhc3NlZA0KaW4gVERIX1NZU19DT05GSUcuIEJ1dCB0
aGVuIGFyY2gveDg2IGlzIHNheWluZyBob3cgS1ZNIHdpbGwgYmVoYXZlLiBPayB0byBtZSwNCmZv
ciB0aGUgc2ltcGxpY2l0eS4gQ291bGQgY29tZSB3aXRoIGEgbmljZSBjb21tZW50Lg0KDQo=
