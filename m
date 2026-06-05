Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071A3D9DA9;
	Fri,  5 Jun 2026 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646317; cv=fail; b=OZkzElWdw2RX5mCnv073jZxzH9ccva9I/dNCvGwNCen/wo5SLNze04PYXhnN5bZN3ixiL/IIYxGMOa+NBTMT4UV12OXkW0u0DIKz4LGS2HrJFfPrePtw8R+xd3+tb+KCSwd+GjE3S+1DSlK6WJ/VUYLgjUoh5zfEvls7mdPzljE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646317; c=relaxed/simple;
	bh=51tEIyzWrd23hdRFQ7FZ45WMJ69328Bg9MWLy5WaFg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L5OWsQySR00qeKOfqjtFHLp9NoC1CtTT0I+L3NyCU/zgHExBTovqW1DfEQWWa8WziwWQveVlbEbHfNhl0O7WdxGikAAgrtMAn4xguREbmlJr5cE4rQqXl5SKWpVF8OAwkHrqIu0qqUyU8ZtsOYLb3Vwtcf2iLNVC30/SKYdKD5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jxAalnV8; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jxAalnV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780646316; x=1812182316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=51tEIyzWrd23hdRFQ7FZ45WMJ69328Bg9MWLy5WaFg8=;
  b=jxAalnV8EKAvddsyjI0I3EjEbdtEjWWtU5qh08OCFLDEn0NF7xsPJWVV
   2CJju73EWHyN4ut1bGO+0QFxP09drhqMgVzQmXnZkmk+lQrdTA2deGhUS
   vYDGZNr8XfRrDMW05gZpz2IVWFCM7Wgxc/KJp+SeLWiXM7RM3o8SIA/1g
   N3eWhHAnrFzfdReMUcma8Ead9Id8Sh8UtSrkrfBAxDsoJ3SbrxiQZ3OLH
   Tx542Vdg/WF6xrecFejQ2ksMOo/PX97ATTIRtZG9AUba0tMmx+BXCysOo
   cLW3Vl3lfiq0hSdUbtAgcf8tsaRJxahcmdXcqF3NVdaqLqba7Od4QauyF
   Q==;
X-CSE-ConnectionGUID: dnGiD9xKTUmTCO5p5/ULWA==
X-CSE-MsgGUID: fpQShojBQsucUuegSLdH1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="80617443"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="80617443"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:58:36 -0700
X-CSE-ConnectionGUID: SHm8MUJuSqurQm9+x5ZALA==
X-CSE-MsgGUID: UNgliKFZQ/aVzjYKg4weww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="240592615"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:58:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:58:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 00:58:34 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:58:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LO6K/Bnmn9UYiTJokK3bWj7PEGpzOxu3tTVp4z4yjoSXzpVtc5/Is8Iq9GRlX8bCZM9ZLm6OXHnnRQFAx/lUA1v7Arsc2eoRvrbipIxMu2kZyj7I34/wbpWS2Pw6QEmqD5qQU2ntjAQJPvcmuuTfuiGup0k9MmawspX2nJVUsQkzgdk/9XPQPTKmwk7rkTEi1seCNexfu8AJmVarryhYtrsfHYyVZs1Aq9s56AeolBZ0AbB22CxX+YAkOiiHORpXOrZyeLL00B6aJPs6FtW13Hn0AvbFzKMxEydAdycVHSeo0788Q4RLqDxURnzICCgguOz7s6obqME/XKrUJCsAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51tEIyzWrd23hdRFQ7FZ45WMJ69328Bg9MWLy5WaFg8=;
 b=qY6jsBri9ybDxAHUlKNqA8Tde0ZPtyRvX8snNsHCns8OUhpUYDMJk+jjzlJ3Ak7uYMHFZqjekjxTWuEYfPVbZsEEB3ZSLOHuSOPuie1EECRUcDjL35ubffHenZIMIXFLuNG1XbgTVjND5lXlbnZjPtmuQEI4JOtmPLMdvqPaZ2kar6Lvm0CYFCx2W7KGkW02Ovq+T6GUBwDAUL3b52chUTn0+6FGw1+OqGiwo/8x2XOisb6LRh2FzyWsNvPGlKxN7Rga/ltJubMOtU0075ki5DYZoY0Wbkp2Q9TL1C/YP5geCe4m++jGdeJHx0Xq1aWmRZWO2PfIQjUWPzf/+UrDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS4PPF31CEE2CEC.namprd11.prod.outlook.com (2603:10b6:f:fc02::1c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:58:32 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 07:58:32 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 37/40] KVM: x86: Move kvm_pv_send_ipi() declaration
 from kvm_host.h => lapic.h
Thread-Topic: [PATCH v3 37/40] KVM: x86: Move kvm_pv_send_ipi() declaration
 from kvm_host.h => lapic.h
Thread-Index: AQHc77nVeWC9L0Kw/0WvSBcDU8Gx6LYvor4A
Date: Fri, 5 Jun 2026 07:58:32 +0000
Message-ID: <0e13d740360de52c61fbdf01ca63aa69765247b3.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-38-seanjc@google.com>
In-Reply-To: <20260529222223.870923-38-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS4PPF31CEE2CEC:EE_
x-ms-office365-filtering-correlation-id: 167c2582-591b-480f-39a1-08dec2d83cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|56012099006|11063799006|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: D7OT2Y3vZfoi+z8XD/11FF5URQVKAdlgesu4lZ0kx/0UHKs0HtiBT7sxCIH7KmkLfnpND0qCA+f8DbjQ+sxwHqPuHe5NWwLObuf8dQnMgjkyFjNPb+MUW6xW+C8SlEqLghbZ6qrG+Qd8QmySSlqa3s3aDCXrAR/ae4k0CD7g0vSdQ5Alay9JK2Z5HiYLTJ5WN67X8UI27YvzfNLRnRWjfRmEL/e2xn0qxMD2Ou7z/q+0Rixaj6Joh0QjsVRVaouTA7n66vspoeFr63PIdAO8nUIfg3utfF20+JQbyDlfyKt6q0l02rO88EOnxY3T8jZF5UsAhe4DJ459CDTxbbvi7CSRc+ecyQHGFsMMZZQAZkE/uc4qfJ9e3/JdP5XKXJPUThu17sNvHYMzuZA93cKiHfo5xOrh21W0W1TylPhi9INa0cGNT+pVRZv4UPsT7ki6MdppOHOtPECPdv+j5WRDx2uNh/NHIGKCzo3bCj20R3RocOwR/GbqEKMDaDk74nXml93UogTvHGrM76As28OWM8yUEZdXrfsnP4X+WhobscyAiKTAG4/tmwytJaYTZKLz4Z+FAVogoQYCn5gFJpsEoih6o5qUPGcvMGLIcZPLjlElL6Cpjd8aBQ2a6Q2UfZ+unqBpCwvyWr6FkPyasZE3LNVCEqW0jiALIh6fxsLURYLWYLsrTOfCt/dLYX6RejMp83YzmoPa6ZRnTVkw0pzOhU1eNqdXz6xcP/CZdASSzvS5OVzpcgX7obVjQhvcmpbC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(56012099006)(11063799006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkNPSDJUM3duR2g5bkcydlkrNkpKd2lOTEZsOXlpN0NzOWVvTjFYT3lvTk5o?=
 =?utf-8?B?Q2xaMEcyS2djZGdTbDRpejZFSmJoUGtwKzZnRWZSRUZsZ2tYSS9aZDdrMEhr?=
 =?utf-8?B?bmxtdTZQVjlVMGIzUnkyckZObnFlaUlxcWNmT3o3MzZid1czSDFiNGlkWnpC?=
 =?utf-8?B?RzVxR3p1bTMvaEFmZFFkSmFHL2p3Zkd4Y0YwR0p4RVByMGxNTE5OakNiMDU2?=
 =?utf-8?B?bWt6WUVaeUEzREFrRmZUL2tiaDF2SGVmRkVhUTVIY0dXWlRXSitnOTdpbzVP?=
 =?utf-8?B?ejNOZmp6Zk5BalYwVEVDTmphQzJVL2NxN0RUN3ZqS3pDeXhGSmZ4NHlzbTZE?=
 =?utf-8?B?cUpXOW1vNTk2OGxCbjFYdTlIZVlhV3VQR1BJbW9zdmdUcG9nNGJXbnpJNmpD?=
 =?utf-8?B?QkZWck15UEhBSUJYVFczM1NGVXVqZmxwa0ptb0FPRitsbXIzb28wUDcrdFh2?=
 =?utf-8?B?NFJsSHYrb1Z3TFpzQVlGMkc2ZTNYRUNRdVdkWEVDU0MxMjZ4aFRZMDVJbDVw?=
 =?utf-8?B?SlJTYTdRUXlpRm93OFkvdW9sVUdBNEpDbnU3U0ZsbEF5OVJSQUxjWisyeStj?=
 =?utf-8?B?ZGc4QXF4aWlIalMyZEM5QlJKc1drUFgrTXBLY1lZKzdpSmdWQXZ2UWk3Znc4?=
 =?utf-8?B?dS8ySjdGakVTV1ZzblZVQUx6QjRERjU1R05jMDFVR2ROdXJMOHdLTWY2Nytj?=
 =?utf-8?B?MklQU0Vna001ZHJzbzVFS29zMWFuYXJ0Yyt3L1hMcFFYSlVid1UybDI1Y0hr?=
 =?utf-8?B?T0cxYytKS0RWTG9nSWRvMHdoaXlqdXlPako1TElLMnlqTVdHYWhJK08wOUt2?=
 =?utf-8?B?dVF1N1pUWGp1bWlhZEdQTWVjdzNSUjVocDRjMWhkcDVaaEVlU1lMaDB4UG4w?=
 =?utf-8?B?azdBM0JBRTJwU0M4UkZUZkhNMVZvWUpXbnl4RFc3MzBacER4L2c1L1NsUURi?=
 =?utf-8?B?VjV5MEdadTc2YXIwcnVya1BWdXpLMnFnR0xrY0t2dE44Vm1odEFzditKQTlj?=
 =?utf-8?B?VWthQ3IxdXUwb2haV2I2Sm5yVFBsTmVIbHkzS0dkSGppNEVQOHZGMUZqakJ0?=
 =?utf-8?B?NUgwZkRrOXJDWGU2bUkxTTA5dVJoQXQ0REExZW95RGR6VnkrMUwwOHdtUkIx?=
 =?utf-8?B?U1VCdDN0MGtzdmJqSFhBWVVqRjcxQjQrcEZNOFFFTERzbC9PZHVjT1FzYThK?=
 =?utf-8?B?Mk1SL0xHTGZMOTRNK2lRU1hRZ296eEV6MmhncmhsSzNaaGMxeFFEOUxTQWV5?=
 =?utf-8?B?cklLTjhBT3ZkcFZHSkgzSVhqblpCbEp5bmFwaUVUUVF0cmQ4dUEzME5TQnhz?=
 =?utf-8?B?NklDOElzWURYb3JYbFVjV2Ztd3ozN2pjdmxaMVlBcWVySSt1eWZCbUFUYWdy?=
 =?utf-8?B?TnFuNUNvRUZCNFRKcHJOVXhaN1Y2ZERJTjltWUk5cGpmVWtYWjFVdHZ5WU84?=
 =?utf-8?B?UTdBWWxvY0ZickJodmVvNHZUbC9HdGVlSDQ0RVVONWNiQUNnRS90QUZQNWx1?=
 =?utf-8?B?UW82RFJRcUMzNWk5eFZsWEExbEIxa3M1NGNYZy9zZERmbjVhanBOM3p4UHUr?=
 =?utf-8?B?TGk3VXhGbWVNajlCSStpWE55R3dCallSa0tWd2tFbXRHdDdUUi8wR1pabm9N?=
 =?utf-8?B?eVR1NzZVd2U4dUo0c2RhZGpEZVhLTkVzelp6R1EyOUxjLzZ1ZkoydU44akJ3?=
 =?utf-8?B?NUJDK0dva3MwTTMxOGFBaksvSy9acURlYy9ZbEpDb3o5VHQxS2l5a0dkYTdq?=
 =?utf-8?B?WEpWT3M1eUdIMHM0ZmNFMEtHVjFZTVJoMVc1OUwxbm1lZWZkL1hBeUVrNXNJ?=
 =?utf-8?B?ZTVoelZzTkhXM3ZwYnZBdCtGTWhKZ0k2NjZJZGgvM3JJWml6eFBzcTl1Y3BC?=
 =?utf-8?B?K01CQWZ1K1hadzhSTDBoQzFQN3M4R05Cczl0YmluOTBvRTdHaWhIeXYyUERs?=
 =?utf-8?B?cFlWakUzL1pWV1p5MCtaZzZhS04wemNqVEd6UVIvUnM4S0RqYXVWRDdYV2xa?=
 =?utf-8?B?ODNlR1dPekV5UVNUYlFteURwUkE5VGkvY2ozamRiTHBKOXliZkNYczVVaGRN?=
 =?utf-8?B?ZytJV000MUM3M1FFQThuL21wb0dQRVpYbFRVY3pqcElTb2k5VDVIK2hpVUQz?=
 =?utf-8?B?WkJZamdTRitDY2JYV3ZTTVRRQUtFSUw5UHRHZjVRL28rL1V1NmcxVGxqYWQ5?=
 =?utf-8?B?aUpKMC80UnZTWTFlK1oydEFLSzQ4MjhtMy9aNGFxcHkxcjNUMjV1SENxVHpt?=
 =?utf-8?B?VWZrTng1Q0pCUGFvcWhjTWdmdndWUWxjODNoMWswbWNia1JadVdMaitGUVhh?=
 =?utf-8?B?Mm8vVXMvZnBQUXA3YTdIQ29xdnprZCtjL2pNNGtOR1o0aEl0NnJqQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C4AFA174F8E2547B496556D9D3CD624@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JR29GenJAx8SopPWpfnjFVbkvx3jonTElsASwAp884VOyMXFmUeL1bryLVk2yIbMpXk2Zfx5PXdw0sX7ghKnu3yYUTZwheQ8p3DrRLBkvhZaorVvfBdPCjM2104oGAhGGlQbbgyMFfAYzdFK+SXrsmLP4d9R4CgRJyCeUDagiLvdw862R3hmbGsiOMLzQ99Ro91OzdaapUr6CQj+tRPXvpv4R5Ph4kSDbFOGMP5eBsbMK07t6CP5rJFcrAOucQbJMiMwVZEB74oWAQGpJy5Mo8REMuGMfmV1Rh8L8RGP9jpKYQbsQo0fkyJ1WZEzV5b7uAahEmeIB56xNiECd0KFbg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167c2582-591b-480f-39a1-08dec2d83cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 07:58:32.1967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7reZxR8QZUES9ZEKDP6CJtFAPmHsBBKe9s/Kt2X1DRuSQffSDIt28eYEn2d2Vn175piPGc1ETm/wGDa6REbtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF31CEE2CEC
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIHRoZSBkZWNsYXJhdGlvbiBvZiBrdm1fcHZfc2VuZF9pcGkoKSBpbnRvIGxh
cGljLmgsIGFzIGl0cw0KPiBpbXBsZW1lbnRhdGlvbiBpcyBwcm92aWRlZCBieSBsYXBpYy5jIChz
ZW5kaW5nIFBWIElQSXMgcmVsaWVzIG9uIHRoZQ0KPiBvcHRpbWl6ZWQgQVBJQyBtYXAgcHJvdmlk
ZWQgYnkgdGhlIGluLWtlcm5lbCBsb2NhbCBBUElDKSwgYW5kIGl0J3Mgb25seQ0KPiB1c2VkIGJ5
IEtWTSB4ODYgY29kZS4NCj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+
DQo+IA0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0K
