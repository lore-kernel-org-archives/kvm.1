Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B53128AB;
	Wed, 12 Aug 2026 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550560; cv=fail; b=IpcbkQjxZjyDI5PUw/VPxeEttSotRAhr+RzvDWa6UJ1l3216dwdP26WPbVjIG6WJwm1FDeb7dMoeYQD1twroi5yawaAvLHSxPjgomIBpCdp6mZFMKnyQnVh++W479kRdhcipCYvu8XzLGbpxKAo39mLCc6G+Y2BliApEmLwybLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550560; c=relaxed/simple;
	bh=Xa/q6igEQb79fMG6/L2lCxD1s3nFqrlDQX37bmoC+aY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hUhF4yZNcPqeykDQxJZYUxub2MnTHOuchFCpt01sCukLhT6AxxKaNSoQSPljyRS+ouYCUy9QhJoi8npof1jjyQnZtZusqPg+T2vdQE2oswYaXR/I/7POXV2VwkRqqsuRYpP0NfYYiZAznYKq+hFaULTLu2AOai5wCk/qaS7S+98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e6fzM5/o; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e6fzM5/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786550558; x=1818086558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Xa/q6igEQb79fMG6/L2lCxD1s3nFqrlDQX37bmoC+aY=;
  b=e6fzM5/oijSTS5N9aJVTSxMLzz35fo+xhNoVxYN7xg2mN2tK79NJx8XB
   O/UWpn0/3mVtRXD8X+CFPuWePuqYom7y6dFFCkrxsnX+hbBCNFsSQw0RG
   32IvXukFAVvc6Yoju2JvMEdfM0kGL6vr1xHOdNlfBfTf9STZFPXxBXz+I
   IqsHDOAcd5Qz333ORtWyI2OOKxDSs1KNzzOcNOVMkoDMBxcYQol88wlP/
   lkDqCWTG/bMp7po7VydgUjQIA9yVZtr/vnHNkGwVZupyyrdQySqjmmkHB
   JhaFwXltBIFbwwn3TpPaMJKCYc1GGYDX1mOBOpXOQk4PEZUC1Bsx+uIgE
   Q==;
X-CSE-ConnectionGUID: d78xetDHQlyqT5vSxe7G8w==
X-CSE-MsgGUID: gk5eWOmuSmu/VAamcz4oiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="104646186"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="104646186"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 09:02:33 -0700
X-CSE-ConnectionGUID: Dv3HHfaPQo22PZYswMVbeQ==
X-CSE-MsgGUID: E4fJyogwT7KCz0GEjpzvlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="287129452"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 09:02:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 09:02:25 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 09:02:25 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 09:02:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnphaLZd1NT1AuYaKhKYGbxZ3LZpEwGPvG7mSQ8CisHujCq9z7rkbODGGWzNMP+MqiUuP6jkqYwHk6RVpVNkifsorGdPF+dcPb1xLgSlkzxlxRd/P7rpSghkpUL0wb8hTD4fCNYh16s4sVNo8E9teDKpcDHdFEO4eDbsbFPo9MHGcifdjtX+bRhIvXhUiQ3N/zEMSclXcDgNcIweKsPPU2ejcRtf0SjuJwYK4z1WXotM9QHomyCIO+eNMoYYUWJiOFXNGYxLscIL438tCrhHezDGHoL3ovfD7sqaer1qkpjoE92p72BT33mbq464eWfktju2XjY7pTdHK11KYL+VUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xa/q6igEQb79fMG6/L2lCxD1s3nFqrlDQX37bmoC+aY=;
 b=ijMxVL+a8CI2ZteIrLI7iaNsZuYr3rvU/b5FvOGf8dcnOWs34fMqPMUvQi+XgfOqffv88IjS+IABeWbaeR2mmH48T5XJp/05qcyZDIA9i6lXZ0K1MPZ1J2G+23nzmlbxmRf8jM4uNEbWoXlBbCKwosQPB+8grYdjyq2leKo0zk7+9TikSe6+rr5HoB6OYdjW30rWrstyh18AV/+/3BBJ7KO+DP3AQ4Sl2E+1BJPqpWoUaz9ln23Yf+JIGPzXMQj6OljVRb4HmuvfQ/7XgHw9BIkK8kCyjeNcmx0+gXQc9JXK5Fx0krFTjt/J/N1iBqWShcc3mlhakw9pHXWxjCOPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS3PR11MB9842.namprd11.prod.outlook.com (2603:10b6:8:366::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 16:02:22 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 16:02:21 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "hpa@zytor.com" <hpa@zytor.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Bityutskiy, Artem"
	<artem.bityutskiy@intel.com>, "Fang, Peter" <peter.fang@intel.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Topic: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
Thread-Index: AQHdH1YE/ME7/hSMIEe/+GB5P8Iam7aFAbAAgBSEcgCAAQNDAIAAIM6A
Date: Wed, 12 Aug 2026 16:02:21 +0000
Message-ID: <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
	 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
	 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
	 <anxvwV_Pz4UYaxxt@google.com>
In-Reply-To: <anxvwV_Pz4UYaxxt@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS3PR11MB9842:EE_
x-ms-office365-filtering-correlation-id: 0791fc6d-1bc1-4a4f-5276-08def88b17f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: ABUzjyYER+nstbgew8eOHbQv9R3+tH7owbfiWzzgmRZcxSfZ6vKc0gl79RgS8BjrgBfwCIPIYyM8P+b/kMa+Rl8Fn+zij5ScVJHLL17JxYQ1J/bNrttsSi4TgPW40KNjUovo/8FTj+4F0tFIGJif7SlyucB4gV4H6UjQye+QMNdAFRd0DRQ2oJfuS9+2+iUvCXtK1FHNp4xzqjTAKi4CU6u8NLUsBpzLmvB0fSANlziFkYvWbFRzG4l8HY+zogWtqXmf8dzAvzHyDE8LGjeYXlb650dN1CASXtd6CoGt08ZUYZRJUrBoQO45DlpjL0nUcaEIcmP+yQHLgVE2kX8sVY+bzz/ew2XMyuIEY8bnDZ7vMQKwukFpJOwwB8giCJCBd9rZ/EtePldvvLiSIXHkMG+a1vBe70TFUhDerrhIdr0SEoT/f3/B7aRCgYePmi3t3j0K1/Sy54lNJmKfVSCZLvAAXepGikWpKlewAv17+SviPenteeU+2Mw2tf08Lj+Ayeh2+wrVdb/Z0nI4wqnAJ3J5dEduboR4l2RRYX6FE+81pcKbXIwCVBG6YBUTYryRso4sF6gvCcJ2AfuZR/8zzlG1Qj23GYyh9ThV5MmGCj5MHxVbRd8BtH5ZOhx+eLa1VrrNz5NKcRqVy409k+pLmDuHDg7sMmwAKSrQRCC8FKd1+IG3lw/QOETRYngQOKcx3kfEw4D4tcuMOkHXuxHtYoE0kjLgN8XthEPDSN6w2mw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0pNbWxOeDBNNmNWUWEremc1ejBPNE93dmYxcno4N0xhVjZNV0xtSFplWGN0?=
 =?utf-8?B?cVNxUHVKdjhaSHZLUGJOWVZhTmJxVVBsSUNPbzdTSDAySG1DRXdwMitHTTJp?=
 =?utf-8?B?YzVlTjhrV0dvaEJIdVlSWE1qeFhVaW12MVQvdzhmMFRsUTdQSnFMTFl5RjJP?=
 =?utf-8?B?bmlxN1RGT0k5VnlDUU15RnFCWVVYbkhCZytIaWFWTy9ycDNKK1NSQ2lDaUtX?=
 =?utf-8?B?dzhwc25jeWdCZ0hHOU1xV0ExSWNFNGxVQ25EQUFERjVtRkxlRlhwQUtFY0Y3?=
 =?utf-8?B?N3J6WnlqSlF2U2hodVRSNWladnJQZEE1anR1U1FGQy9DaXJIVGtFbHNwTWlx?=
 =?utf-8?B?aEdUbjhKUkhqTWZZTnUvV05zemdIY0syTlJHZG9nMlVXWFJ5K3ArdFdkUmpC?=
 =?utf-8?B?bldyc2EvKzVSZ1NLblBqeWt5a01xL1pVdUkxbTdpYng1cy80ZSsxaUcwWXNB?=
 =?utf-8?B?QnlXWm5PVjdpUXhhLzZnQlBocDNJa1lVd01MWkM1c0ZMNFlKQ2x3cjRCTlo4?=
 =?utf-8?B?Q3Z5N3Vob0MvTUsrSnh3VHVDTTlGTmtvMW01dmE4UHpnaFZBTzhkZGhxNmNV?=
 =?utf-8?B?ak80MFhNTnNGeTZqaHp4ZFc3NmdlUHhnaHVnUUM3Sjh4cktwM0ZRQ1dKaHha?=
 =?utf-8?B?WjRoamlsWDBobmhTNDFGMjN0dmc2NkJMSzM4dForeFdoaFl4TmpEK1VWZCtQ?=
 =?utf-8?B?V1pOTmk2QnlVcUNPVVZOQk1iMi94U3dveWl1Q2g4NG5WYVBMM0RPVFFpQzAv?=
 =?utf-8?B?Y1NGYVpQeWFWTmV5bGI2NEFtWkRBTUQzd3pzdXMwOTdQTHpmQnhPdTRTOGh5?=
 =?utf-8?B?WFRYeDZjRVh5RTBFOUdudERMdDM5bHVuem9MQ3pwQVNxNEYvN0YvWmM4eHJW?=
 =?utf-8?B?SktPdFpTUDhDQk5ram1idHI2TytqUTl4TFRPQnlhcVdvK1FSdy9YbjFpYWtl?=
 =?utf-8?B?SVlhTDNncVFLYi8vV28yOHJUZU90UHJISzl3eUd5dnpWS0VlOFdSUEtxbmpE?=
 =?utf-8?B?WW1xWnpyNmxpVlVHN2hzVUsrVDhENWdiU0JHaVJKK1FtVGFjeStueWJlb0tE?=
 =?utf-8?B?Sm5FZlZOK3UzK2lJckpOeERPdmlqaTVyZkVJaE9JL2xZbERrYkErNzNDSCt1?=
 =?utf-8?B?M1NMMHNNYkhlaXpKV0pkVGFsNWhtZ0FuUjJwb2xkcmtHcUd1OTFQemR5TDV5?=
 =?utf-8?B?VW5hYmdjNWdONG56VGQwa1ZLQ0d2eWlKTkVhK0FGWHRMQnYrWmpHTTJjc1No?=
 =?utf-8?B?ekVzMldXS05iZ3JRbmVKbHJXZTlkMmYwZFRXWFhqYnpVVVdMTjZXa2pjMjR0?=
 =?utf-8?B?WW50VnkrcU5RSXNkdFA2VVlSNFduY1NXWVgxSng2WXVIenpCeVFJeEorZnl3?=
 =?utf-8?B?dE12OWphdVQ1eFpUeklxbENEL0ZWMEE5MTZlVWFkbDlYZkFSdytGR1FOM09r?=
 =?utf-8?B?c0NqS0JibSs2TldUL2VuR1JOUWtGd1RmTGhkcElpRG41NjJnYzR2Y2pSN2Vt?=
 =?utf-8?B?ZjFJVXpUNFY3ZGxZdjJoZVhsSFNqd0pvM1N4bGV2cVRIcnNwRG1BN0tLeWk5?=
 =?utf-8?B?NlVzd1RUZGdCWnVuTHlIeC9kODc1WVdPRU5CUm8wbEFJM1RISUVjV2pkNDNS?=
 =?utf-8?B?OHlmYm5WTmFDYmc1SzdOdHRKb1hTbHdoRUtPaGJXM3BWZEVSSngxdWxWaHVR?=
 =?utf-8?B?VmhjZUtzNFprNzBDcHkxdXJHcjhXYUwvWHFEQnBQZ0xLZStMZytHRXVvQTR1?=
 =?utf-8?B?SUF0bEpSZlJWbVRvcnIwWmJnbUJFZW1ieEZOZzliTjBlS0J4UHdMZ3RObVFm?=
 =?utf-8?B?YXJJb3VlbWZReVRJZEdpZDBFbjBvcGI1MEFta3VpUkh6Y0JmaTBmS1FxSUxP?=
 =?utf-8?B?RDJ4TTNJRmlhZXkyNzFiVGFLT2MzUlhVeXpiSEdHc2d0VS9nMURGZHhBTCsy?=
 =?utf-8?B?dW9MaHNQcFRTcUhJanNGUVlmZE05K3JUSHV6c2Fubk53UDRKSDJzdGp2MnEr?=
 =?utf-8?B?a0ZBYVdBK28zaWFybDluWUQ3RUxKNm5ZTURmTEN4ZjgvdnZXUTJveklPejJM?=
 =?utf-8?B?SkFFR1hZemk5cGZhcUdyMVBjTlFHYnpYU1dsdlNVTUMwRmRGb2NhRWg1c3o2?=
 =?utf-8?B?aU9QdE0zYjV4a1krblpGZ2UxVGYvTFFXRFl1aHgvS2MweHVQV2tnZlg0eU5G?=
 =?utf-8?B?bUtuTkIvTHB0dTNZV3ZkdjJvdFZtNGQ3TnVPWjVWcWgrSFBlSVRHSmxwTTJZ?=
 =?utf-8?B?NXgwOU9yanFjT0dpN2VKUVNBVFhjK0dSSDFWV045WUJUZDg2dlYycEExNS84?=
 =?utf-8?B?TUhKdUpXbzN5SGJYd0V4ZVlHRmRSMVRWY2JJdTdwNDRaY092NEFDOW9RdkJZ?=
 =?utf-8?Q?NusVStwNy5covFic=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A9ABDBB43A9E149941B5FB9E71956E6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k4KFxsRiUm2yEo/YvCHeYlgo9kdeX710r5DEmjNpwljLBYaUmxi9ShPC3JezT2fvl+rHzEK6znfLd8UKzkvA0Wj7zRpruOt6orBE9WzlLUb9hvTEb8//fWOkb4ES5/HevEOw9S7f4b+b/0yMBy1SwTA+WbrTHK+Iz00pbHkYCszxkioc0fmDqctVJa/93uRB0B6h9T5JTHjobfnjprNXVZ5foY4zIW7GNwzTzL9noIMSaUH09G8/w04zkwydvtU5T/LTSLAyVUq7H4VpD0xvC42j97rwUUb2zt/8NDcOC9c4URV/f3w+qOJBa7ta6xklcHjdriYWz61a2eApd1emsQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0791fc6d-1bc1-4a4f-5276-08def88b17f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 16:02:21.9157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlwUvZTDCKMQ4lgo4EXQp75fu1WlNRO13FvVvDKOh6DWFHV2bOku8bdvR0j3KKLy4m+Rxh56FUw6TnzKh0nxYj45IGlxxPI50b5yBObN0Lw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9842
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDA3OjA4IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiA+IMKgIHxOb3JtYWwgcXVvdGXCoMKgwqAgfE1pZ3JhdGlvbiBxdW90ZSB8UmVwb3J0
IHNpemV8UXVvdGUgc2l6ZXx1QVBJIGxvY2F0aW9uwqAgfA0KPiA+IC18LS0tLS0tLS0tLS0tLS0t
LXwtLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tfC0tLS0tLS0tLS18LS0tLS0tLS0tLS0tLS0t
fA0KPiA+IDF8UGxhdGZvcm0gc2NvcGVkIHxQbGF0Zm9ybSBzY29wZWQgfEdyb3dzwqDCoMKgwqDC
oCB8R3Jvd3PCoMKgwqDCoCB8VERYIGhvc3QgZHJpdmVyfA0KPiANCj4gV2l0aCBteSBLVk0gaGF0
IG9uLCB0aGlzIG9wdGlvbiBsb29rcyB2ZXJ5IGF0dHJhY3RpdmUuDQo+IA0KPiBBbmQgd2l0aCB0
aGUgY2F2ZWF0IHRoYXQgSSdtIG1vc3QgZGVmaW5pdGVseSBub3QgYW4gYXR0ZXN0YXRpb24gZXhw
ZXJ0LCBmcm9tIGENCj4gc2VwYXJhdGUgb2YgY29uY2VybnMgcGVyc3BlY3RpdmUsIElNTyBpdCBz
ZWVtcyBsaWtlIHRoZSByZXBvcnQgc2hvdWxkIGNvbnRhaW4NCj4gdGhlIFRELXNwZWNpZmljIGlu
Zm9ybWF0aW9uIHdoaWxlIHRoZSBxdW90ZSBqdXN0IHdyYXBzIHRoYXQgaW5mb3JtYXRpb24gaW4N
Cj4gcGxhdGZvcm0tc3BlY2lmaWMgZ29vLg0KPiANCj4gSW4gb3RoZXIgd29yZHMsIHRvIG1lLCBU
RC1zY29wZWQgcXVvdGVzIGZlZWwgbGlrZSBhIGhhY2sgdGhhdCB3YXMgdGhyb3duIGluIHRvDQo+
IGF2b2lkIGhhdmluZyB0byBtb2RpZnkgdGhlIGd1ZXN0IGJlY2F1c2UgeSdhbGwgZGlkbid0IHBs
YW4gYWhlYWQuDQoNCkNhdmVtYW4gY3J5cHRvIHBlcnNvbiBoZXJlIHRvby7CoEl0IHNlZW1zIHNj
YXR0ZXJlZCBhbmQgbWFrZXMgbWUgc2ltaWxhcmx5DQpzdXNwaWNpb3VzIGFib3V0IHNvbWUgbGFj
ayBvZiBwbGFubmluZy4gQnV0IEkga2luZCBvZiBjYW1lIHRvIGEgZGlmZmVyZW50DQpjb25jbHVz
aW9uIG9uIHdoYXQgd2VudCB3cm9uZy4NCg0KSXQgc2VlbXMgdG8gbWUgdGhhdCBmcm9tIHRoZSBv
dmVyYWxsIHNvbHV0aW9uIGxldmVsLCB0aGUgcmVwb3J0IHNob3VsZCBuZXZlcg0KaGF2ZSBoYWQg
dGhlIGRldGFpbHMgaW4gaXQuIEl0IHNob3VsZCBqdXN0IGJlIHNvbWUgbm9uY2Ugb3Igc29tZSB0
eXBlIG9mIHRoaW5nDQp0aGF0IGNhbiB0aWUgdGhlIGd1ZXN0IHJlcXVlc3QgdG8gdGhlIHF1b3Rl
IHRoYXQgaXQgZW5kcyB1cCBnZXR0aW5nDQpiYWNrLsKgRG9lc24ndCBpdCBzZWVtIHdlaXJkIHRv
IGdldCBhIGJ1bmNoIG9mIGRldGFpbHMgZnJvbSB0aGUgVERYIG1vZHVsZSwgdGhlbg0KcGFzcyB0
aGVtIGZyb20gdGhlIGd1ZXN0IHRvIGhvc3QgS1ZNIHRvIGhvc3QgdXNlcnNwYWNlIHRoZW4gYmFj
ayB0byB0aGUgVERYDQptb2R1bGUuLi4gd2hpY2ggYWxyZWFkeSBoYWQgYWxsIHRob3NlIGRldGFp
bHM/DQoNCk15IHVuZGVyc3RhbmRpbmcgd2FzIHRoYXQgdGhlIG9yaWdpbmFsIFNHWCBhdHRlc3Rh
dGlvbiB3YXMgYSBjb21wbGljYXRvciBvZiB0aGUNCmRlc2lnbiBvZiB0aGlzIHN0dWZmLiBCZWNh
dXNlIEknbSBub3Qgc3VyZSB0aGF0IFNHWCBoYWQgYWxsIHRob3NlIGRldGFpbHMgYWJvdXQNCnRo
ZSBURC4gSW4gZmFjdCBJIGNhbid0IHNlZSBob3cgaXQgY291bGQgaGF2ZS4gSXMgdGhhdCByaWdo
dCBQZXRlcj8gU28gaXQgbmVlZHMNCnRoZW0gYWxsIHRvIGJlIHBhc3NlZCBpbi4gQWxsIHRoZSBl
eHRyYSB2YWxpZGF0aW9ucyBldGMgb2YgdGhpcyBzaHVmZmxpbmcgaXMNClREWCdzIHByb2JsZW1z
IHRvIGRlYWwgd2l0aCwgYnV0IGZvciBMaW51eCwgaXQgd291bGQgYmUgYXQgbGVhc3QgYSBsb3Qg
bGVzcw0KY29uZnVzaW5nIGlmIHRoZXJlIHdhcyBub3QgdHdvIHRoaW5ncyB0aGF0IGhhdmUgdGhl
IFREIGRldGFpbHMgaW4gdGhlbS4NCg0KVGhhdCBzYWlkLCBmcm9tIEtWTSBQT1YsICgxKSBraWNr
cyB0aGUgYXR0ZXN0YXRpb24gb3V0IG9mIEtWTS4gSSBzZWUgdGhlDQpiZW5lZml0LiBCdXQgYSBU
RCBxdW90ZSBpcyBhIFREIHNjb3BlZCBvcGVyYXRpb24gaW4gY29uY2VwdC4gVG8gbWUgYXQgbGVh
c3QuDQo=
