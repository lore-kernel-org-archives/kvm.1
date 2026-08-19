Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC839233944;
	Wed, 19 Aug 2026 22:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787180275; cv=fail; b=Xx5+0Ym7Jlz/flpvJH5MY/Az9EI/csylXRuhoBTzcegSTN6EFO8TKhT7m3qgL8PWonmztOv2D2nyb3JgEYhJhKVecgb+E/k3k6Fs/W8m3jQhTOWOcuyYqQvtjnib+PBYk5ZpT/mbCvq+U+h8LJL70B9i+Ozh7OwcTFhd7pQDWwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787180275; c=relaxed/simple;
	bh=JSPrXsxJR6Dur5dqt0FDhoDZliiwo6l5x8EQKcWe1Co=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ePZ7crTXS+aKhHYT0TB6clNv7dOBflMFCf6XVY2vvkzldXHqSvWWNcv6oGYMxjKgMHUiYbIauXcdMwSNlUOf29MDcfHgyaViDB9OVPVKauD6A+Dc1q/hFJopoZ1drIEX+n6+gdjBE4X7bJR0uTwb7kQAHmvKcBmjzQxrGrw+0XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImyxKCJe; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImyxKCJe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787180274; x=1818716274;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JSPrXsxJR6Dur5dqt0FDhoDZliiwo6l5x8EQKcWe1Co=;
  b=ImyxKCJe4Iwe4fPVytdZ71PQKtf+ibPQ4G3YDcJdAo1dNeP0Lo1XVDIh
   lJzjP6IHI9vMRcK0Vwn+uEKlmLg2Z3UcnbjO7hSj91k9OEqCE45w6/Zw8
   uZMs2gWn6egnbVW46pceJrTLfnCGbr9mR1FL1d5dc4utAhlO/RWcg7DNa
   hokQiIxqlWhVOp3NdnhyHg2cxt/RDG+K83fMrF4oba0woYVG/OAJeTJpx
   a4NF/p284LGRq2TX4KTAyM/hUeg0hFvrykLRwAZbRr1uCXesWOn1dgGSg
   uwdvjc8hvJBSAMq6vFidRRqKk1H7TCRAql17+1VdAPzS9Iyyc3KxswhE6
   w==;
X-CSE-ConnectionGUID: j5u3HSG5SXGO44eloK5qvA==
X-CSE-MsgGUID: CaGp8q/+Qoi4Wx47Yg3c3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87578933"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="87578933"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 15:57:53 -0700
X-CSE-ConnectionGUID: Ko8DNV4ZRTuenT5E5SMGEA==
X-CSE-MsgGUID: iDN9es3kQPqi97B/L5ZZuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="263942207"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 15:57:53 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 15:57:52 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 15:57:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 15:57:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSL4OWvu8xj8K0ucG4FnrlCR5x/c1Y2JpFlyB3yYSfklBZLwSeMLxOOfQAeiBqmnJr9HmZaFjGpY8oVygXOPE3g/npVEvbJezxf5zHHRHeM/hF6t9e0A4k0DjpwihM/0N8Mh2MFSxKuWXm5a8p9A4ZMaDi9jlrD4+xg/me2PW4Xvr1xAaPXJqi+bbPn9su3QHC87aZuPsGXltEcW3gkH6uP0DvkCtlz1N9UpGivCJAU4d+PmyP3gHt8wb03pslBHTtRo6pUH0e6gPyMoMGt3t8HpVoexF+IjEBuF6wwgyUNLaF3Cse+KfFKnBtsnMQNbe7KmgF23s9LVDWLFUk/2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSPrXsxJR6Dur5dqt0FDhoDZliiwo6l5x8EQKcWe1Co=;
 b=x3MOqZa/7hb7ZkMmmmtioJnAi8mlK/JUd72lHEUBMHtJfiSSdijQjfh2uW2x5EAvxyQr8pCmA1lOwLhX+ecWOJLTdVym4+sjyyMDPGnOiCvkPogjnaje1Y1ftZOyoew7oeFjJ+o9RPd4XVwu3v9IBGAyMEnQCzYtqQF7Gy1jGqIlDu2I97BUsecoL1zfOCItTJn+OVOXoufehjn85GKr7XRfMpSRgt+xlzULfzYOs4XIt98smxGSOk5ilQfbIDbxL+jNZeH5I9V1tEGaxzWFu0wL5UpVphxC/kHpJFbDwiBV5EuJY6iqGaqkhIXvVSr5NypfFT85/xxBBzJiQHdI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by CY8PR11MB6963.namprd11.prod.outlook.com (2603:10b6:930:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 22:57:48 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 19 Aug 2026
 22:57:48 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v4 0/9] KVM: TDX: Enable VM-DoS Prevention Features for
 TDX
Thread-Topic: [PATCH v4 0/9] KVM: TDX: Enable VM-DoS Prevention Features for
 TDX
Thread-Index: AQHdL8C6QuXdUudLCEyObw22H+eGfLal/caA
Date: Wed, 19 Aug 2026 22:57:48 +0000
Message-ID: <5799b5d637f6b540c45874120aa37749a7dfb955.camel@intel.com>
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
In-Reply-To: <20260819094903.3060020-1-xiaoyao.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|CY8PR11MB6963:EE_
x-ms-office365-filtering-correlation-id: 50a36614-6066-466d-192a-08defe454a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|22082099003|11063799006|10067099003|18002099003|38070700021;
x-microsoft-antispam-message-info: fgsK8T/dRQpnWxHDhkGXba8lfBatZsASqyQSqiDr8z/mqhfSb/o/5u252Rwsu3xn8tU9+Wa5hYU7IzClMnfS5HdsoOUFbJC3hsKohIk5PoFO1hAoUrkzPdotw12zz0MTx6C3NF7roXoBusBqTL3LrLdL8UElOajbSRv5Cfe687yjtKjZZwc13auiSeOjpa9tfwcU6Is7yHnH3Lgwz0APHE1NhCr3cbd0K1wh10w4g9pnNbZU1qNdPwQPonqk8pM6I39QfZvvVkRjR72BsWCswWFTQyIsbjn7GlleFKjHlfmLgoDCIY9y3NJns54ydfpyv6RrsanhXITxvFBPVzq09YTjhra3OZV+0buZgqgB6vbtGbrONyq6W0Ya6ABls0JvJahT0C7eqUIRrtrkn4qo/aOIOJr2wDOAhkpNdWwAMXgi9xsrKigiBGqNeQVvvdYcTuFqziMLiDRfbgd73dJ7HPu9Sgs5MjAdqh6yDJd4q8Ol4Y27BHRCAv1ExFHefFKHC3atfkE+zFUMgijWDXnplWQLCk1kfO+/JWt5cvxeG89nhDfrWCKL2mWrrlbIeH82zx4D4UFAoYD2pVvHzGrh+zQ4z6oFsgsYwdw6/sZqRnRI7Ng8vuFagqFXHVsMU0WwQARUyz4X5hsb9kKEaGXbN3qx/gljJL+4wAYY3srTy55W7uHYOJ+IMOMpet5bDD5s6SB5wqPx4kk8/YxhDiThGz67NBtVfpIqHOez1v8+8Ac=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(22082099003)(11063799006)(10067099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDJjRExzWjhEY2dXaTJEbU5MU0xmUDdhU09DWE1ZNm14RHo1WUNIY0l0eXV3?=
 =?utf-8?B?NWVtMk9JMWZPVzE0QStUODc5b2JGZDBwMzBNcGlaK0FDN09QUWk4bXArU1F1?=
 =?utf-8?B?T2FxTklIa3EvTW1mTHZZWWh5eCtHYmJJYXd2TDMxUCtCVWlKM0hHdXpyOUJG?=
 =?utf-8?B?c3ZTd2tSVXJDN1VDN2E1Y0hSRWg1ckFZTzF1YWx2RmpMODFaTWJrYndlLzA0?=
 =?utf-8?B?eUtWWTdhcGNxbWlWcHlxTXpiVnNXaURiMFF6LzVWSTdBdWdEaVptK1NYdmxJ?=
 =?utf-8?B?UFVrUDBnNnp0SytZb1J5eWdBQ3MrTy84clliQmY3amRjWlFaQTB6cHlwTU9Z?=
 =?utf-8?B?ZzBXMzcyR2E4NkdSeFl4L0ZrZXFhTzhQUVBLK01mS09BazlEM1dvQmdCY0Qr?=
 =?utf-8?B?NGlnb1M2QzNnVmlPU25CVUpNaW5nOUhQMTlRWDJCV2tjeTdVTjNNd3MvSHZ6?=
 =?utf-8?B?MmpUczluN1NJTUdKNWEzM1ZUT1hJeHJIODBpQW5uTmpIalpoNWw4VHZFUmxP?=
 =?utf-8?B?WUxnaFZoZkNHSFRYU3FpS0o3M1J6Ymdjc0t2bVJLUmY0TTBJcFMva3Juc1Ji?=
 =?utf-8?B?WWhaVlJ1Yyt5SEtrNkdqeVAyYXN2LzFjbFVHUDRQcUo3QkpNWnoxWFJFZkgr?=
 =?utf-8?B?eWN6MmJJcjFLSkxOeklSRHFTR3FWTU5Ya1VsdzlUZjYwcWtRYngxTElqNC81?=
 =?utf-8?B?SUdLNHZvdlVxaDlXZXRsNURVTjhvOHg2WXY3QisvV3ZZc2kyelI4ZVd4TmZj?=
 =?utf-8?B?cGI2dlo3ZVA3cElXZG42bE1QTjUzeG93d2htbHBJQ1BQZnFjVkc3ZXVybUZ0?=
 =?utf-8?B?eHZVTWdibHhhaGc2dHNod2JoQ0xLRmIxKy9nWTJaN3FENW5WemFDbGdjYmVJ?=
 =?utf-8?B?ZmhoQ2R0bEtqYldJaFZFWHROWURvT0hmOXJtQnVIeFBIcGV5TUhRWUhRUmFs?=
 =?utf-8?B?eWY5emR6cE85WXdPbU4yYWdCS0NwZVEwSk9zTzh0b3I1K05wU1FIVHRuQTlS?=
 =?utf-8?B?ZllGK1J1cFE1cDlHZ1FETVFYakxxcDJVQmJRL2tVayt1QlprUFQzaXB3RjA3?=
 =?utf-8?B?a0JMSG15Rkp6Nm1peEsrL1hSRWRpc3Zyek9oeDkvV3hDSHZNQ3ZOK2ZiajQv?=
 =?utf-8?B?YWJ0R1U1czVvUEt4aUJSQnBMVXZ0ekV1b1hRejE1T0VVOWxESS9kaHhOZndx?=
 =?utf-8?B?eHRoZXA2K0YybVZFeDBtcy9LN2QvTW9HdEk3WXdDaFBnWk55TVFZWVlWZGc1?=
 =?utf-8?B?Y0w5dFA5bkdmZmRLY1Z3OFpra0kvTWxSQ1lQSmpERXlGako2TTRXMUQ2QnZE?=
 =?utf-8?B?OXVSckxoRk0vd2MyS3RJTyt5ZmJNcWpjNGJYaFk1Qit4MkVLT2RZVEtHTFU1?=
 =?utf-8?B?QkJGUDNaV3MvS1p3UE9LdlZycmF1TEV1aXRVVXFaK0pzOGliU1pzaTJteHFu?=
 =?utf-8?B?eUt4U0lLS0VGZUlTY1Y0OU16MmkxUlBNWGxibFcyLzVuOXlyVnlmakY4c041?=
 =?utf-8?B?dWFhZUFYRUxNQ1I3UHpVOTJibkhXamtRNmI5eWZxblRmWisvMytSQmVLRW8x?=
 =?utf-8?B?MzFzVU5zK3B6TVVFTzYvM3h0bXZmZElqUnUvYlRFOXV1RU41eGlXTTVGZUc0?=
 =?utf-8?B?MjNZVkRFbDA1ckFaNWwzdXZiUklUV3dlUURIcFlGMmhGaERwWHBuL1R1ZDhU?=
 =?utf-8?B?WGJLYklwWnJHVlM4TVdNYWJ0N2tpcGJxeHBnb1ozTlA1aXdDaDRUKytzUEpJ?=
 =?utf-8?B?R0dXZEk0TG03TThjYVVXMU4wclJORnlaaXNrUlppZm0rL1NKbnZZMTNnMzFP?=
 =?utf-8?B?eWFVRk1tQTBtQVhWUWdPbGR0cjdrbE1Pa3J5dDFtanJlSTNEbHhlSG92MDRw?=
 =?utf-8?B?b3IrZTN5QTJuV2h3ZExTdHhQNWFhWVdVMlZOSmE4Ti9GM09pb2x3Q3Fhc1lu?=
 =?utf-8?B?NERkYS83UjB4ZnlCSlVZcmhHY0JZYjl2WXFSdEx5TXR1NkhWS1E5aHdjUzVO?=
 =?utf-8?B?aXJDTmprcnRCaG1yUHdRODhxNlR0Z2o3NDNla01BcTVwNU40bWdGdGxBRmlr?=
 =?utf-8?B?UHNkVlFWRTl3WU5KZ0hSNk1KVzJOSUpXU05kaXdCdXBIOWpRMUlpdDcwYWJl?=
 =?utf-8?B?RDVxK3JibmI0UGRDbGx1eDhwY3pjSlFYRk11d0hZZlhwOTh3M0tsaXJXUGJI?=
 =?utf-8?B?TExLanhhdzlaOFI1YW9GZDdNMHFQTG8wbTNwT2RDMEU2ZkRnOXQwSUVWSG12?=
 =?utf-8?B?dStFSEU1cVVXK0xtZ2JBOVM5dmVWczVpSzRSMWc4bThac3ZISG4xS2ZlSE9N?=
 =?utf-8?B?enF1SkxvMlhyN0tVZ0ZLY3R6bWZVTjczWUpqU2VQK1lwTVN4bjZlU0NVaE5N?=
 =?utf-8?Q?zY1Pzyx/yNphF+tU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <501475D3A5961443985B09E607499BDA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mYysgsgZGf8ZU9BKHWl/eR+XFW8/1NxjdLAESoT+BPMpE5t4QZO42tCiDa9l2cDn4tGD+VL8NX073wBQickCP/uBaZzGYmuShSamO9LUf/KnXmhAoM2aa3tzFfATly333ldDujV2NgFgQyzAWi3+ZT9GPEdkOVwfV47E6Q3pYIRtmMqyXROajLnCT+clKMFmBo/tiBABNOVbQXePT2jPyQrsb98ZtoteCg0YTQQF6nlGqDtTKXlLb5gd1PAGapLgxVAjL6Z548JSeMrcv3Pz1Q4lLWwBlytfYKfONE9lc6svhP6IceUWFSg4fq2TO2g8H7Gxg2qnSelcUXGEZPjx8w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a36614-6066-466d-192a-08defe454a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 22:57:48.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMtualPUyFvEfB73fzp9ZA89C+wI5tbFEfut5Y37ABbLUTp3ANiEk00oGNyCFhHc/WUmF3ZWmXzz0XYkaCg4F8xoZVGl1YbW2osMBQLzvxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6963
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTE5IGF0IDE3OjQ4ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBQ
YXRjaCA2IGl0c2VsZiBpcyBhIGZpeCBmb3IgVk1YIGFuZCBpcyBPSyBmb3IgY2Mgc3RhYmxlIHRo
b3VnaCBtYXliZSBub3QNCj4gbmVjZXNzYXJ5LsKgIFBhdGNoIDYgaXMgYWRkZWQgdG8gdGhpcyBz
ZXJpZXMgc2luY2UgaXQgY2FuIGhlbHAgc3RvcCBTYXNoaWtvDQo+IHJlcGVhdGluZyBpdHMgZmlu
ZGluZyBvZiBWTVgncyBwcmUtZXhpc3RpbmcgaXNzdWUsIGFuZCBpdCdzIGFsc28gbmVjZXNzYXJ5
DQo+IGZvciBwYXRjaCA5IHRvIGNvbnNpbGlkYXRlIHRoZSBleGl0IGhhbmRsZXIgZm9yIFZNWCBh
bmQgVERYLg0KDQpUbyBtZSB0aGlzIGlzIG5vdCBhIHZhbGlkIHJlYXNvbi4gU2FzaGlrbyBpcyBn
cmVhdCwgYnV0IHdlIGNhbid0IGxldCBmYWxzZQ0KcG9zaXRpdmVzIGRyaXZlIHRoZSBwYXRjaGVz
LiBHaXZlbiB0aGF0IHRoZSBzZXJpZXMgaXMgc28gYmlnIG5vdywgSSdkIHRoaW5rIGl0DQp3b3Vs
ZCBiZSBiZXR0ZXIgdG8gbGVhdmUgNiBhbmQgOSBmb3IgZm9sbG93IHVwLCBzbyB3ZSBjYW4gZm9j
dXMgb24gdGhlIGNvcmUNCnRoaW5nLg0KDQo=
