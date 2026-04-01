Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CC32F764;
	Wed,  1 Apr 2026 23:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775087161; cv=fail; b=S1inmS/yJmfbPQv1h++DBvn5P5WQfKErQn0Vp0wI66sUQIacC4qolvuZgVc78Sg2je0G3fWYN679BaCBBN/rhJGT7BX75eOZch4ETrNkLlK9g45SzYaG61u8y9T9MhlNDQXFpMUC233zkrKf5id9vvA4+NRLMwTQKUcgaq554i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775087161; c=relaxed/simple;
	bh=zPBT2kvyrVcWopIQ0am4w/xab+nXrjeY+PAxc+YjSb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CTwcJkQfP5pqsN7G59xKjG/PLf85hUWL+eGvwnjZEibxmtBTrMASNWR7pKn1uRHcB4m/tBr/HHpRPgsc4Ww7srPRRzveZgMnqyU6hwo0u+RwDgNUIbeAKATMaHjxcGdR0VWsV6aEZFsD72m8gCNpe+02SjaF228fOZjBr++EoN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HU1b99pl; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HU1b99pl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775087161; x=1806623161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zPBT2kvyrVcWopIQ0am4w/xab+nXrjeY+PAxc+YjSb8=;
  b=HU1b99pl+1DjFeY0rbVzkcQ52ns0oJRbUhDVBmk16uu7A4GyrWt+XUiG
   ErUv/a+CbfduFVcLdSGJLfe6o1vjLsF2QxvBVAnJyC/BJzdc0KdLtk1TF
   8HFzDuzaZOC6LKlsQcmMcYrKxOlCmyeIs9rXNTOKw1tJzJMxaU37OkT9O
   dkqsWBCJJWciCbYVmjE9Cxy1kQSwkf64JXUMu79zgYMpTfqUndt/3V+9X
   N31/pEIlOYwnipPmvlpvizBCRJjOgfbm/HU70ivqgSt8eJq2WnbB6y1fR
   H3rRUAEcKiOM2zF+dtLLIQBnRpC0E2DXtbP41Z59b9Fx5RuWHLlqHZNVD
   Q==;
X-CSE-ConnectionGUID: xs4X908YQ6iFgcJvxxhXUA==
X-CSE-MsgGUID: 74nKh8+uRv+nj5gCQ3chuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="79996910"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="79996910"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:46:00 -0700
X-CSE-ConnectionGUID: iK6QmFanR7yV9gKEjkhdgQ==
X-CSE-MsgGUID: QHdCRo2QReKJVGbE4El6xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="220167656"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 16:45:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 16:45:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 1 Apr 2026 16:45:58 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 1 Apr 2026 16:45:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2XLJ9nHV1jMAOaEVj5nT5/9XZQrII+P6423LE9AvOQYZamy7YX5kTXF122mfClBeF2kD8213/kHF2w+I1dEhxeC6sFq5DgmTv4JFGOdc01OU0boKslCjnBvedDcBlnCP9U8xTiFdNRB7REOKIdRV3dC7pMf+yrtT8ti7tyh+aLbEhcEJd551o9ZDBhGARhUyKwmf+Sfy6cW+Kf0qW4qVTOWy4JQRQuUTs2in+6y9SePPcNMMqyFbA3P2RvoD7TLvmOWq+0FPtSGL54QbZ1uV0MASyWx3peIzoXHmyBy/xIFi8cNra2tolCRB/064PyKRsPIR+To7tm5ObyCli8Low==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPBT2kvyrVcWopIQ0am4w/xab+nXrjeY+PAxc+YjSb8=;
 b=JrlaeHB8tAXf9g8pqAXEWY9vTOzr1pDVlNJq1PY8pSSW7FJWXrxWrzqRb2AUUXjMI3Z3hTUC1rIk8c8EwYjLhbORcc58ahwzhk5pGSADqNessKRk2ORzmEYNcY9ueBvvCYJhP+6dHkAq8xt2cAzdZEHtWm5oebCGQsgdzJtfYRrEmiM43omOS39NlV0sP5xGhK4IsUCOFwwSo4CTrC5wE+0n8RbSFCPX6sFFu6ToUdriGUOJ4A62uSZpMAoP0/i6C473J2rz2dKcrfs3ezme6ZUS5lIogbdV8qdiZ8YZhl/B5SOqyoG2DE/Vltn0zOfkGsu/WfyECG/WHRWVdpB1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY5PR11MB6164.namprd11.prod.outlook.com (2603:10b6:930:27::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 23:45:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 23:45:54 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "seanjc@google.com"
	<seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Topic: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
Thread-Index: AQHcviZXKVkTxmL/NkWOkEaa1Zh4L7XGnJGAgARKfIA=
Date: Wed, 1 Apr 2026 23:45:54 +0000
Message-ID: <8a107d4da92d4cf910f9a70991a0e67b42e04d4f.camel@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
	 <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
	 <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
In-Reply-To: <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY5PR11MB6164:EE_
x-ms-office365-filtering-correlation-id: e1770d39-91b5-44dd-a1c0-08de9048d0d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: RGe7ttd+Qyykj0yw4Dm7wizwDlWvwKM5ralvJJrUBnqVp0/hnoZkIKXFrcD4vO6SXct+1qU8/RqGc8BqwKt9cyzmGPl/Qv7yiAfY41VTwPq7xNo/CeSaXNXU4Iw5lpykcj/KzDhcESkJ4uN3N1cGwdqTHdfqpvwNtwgyZhN7fy9HiV5hyDJjtE4ZNR6VPJtqDAHJ+Be8QkXb6IBOyGn/pYR+qlMBD3JQL1RUAmlEnNZtkEFcFH4aOwHN1k35l1+BBivtPXOtX0WxjMLTkDkfcINanfWXoJkHwbVJFDwTE+klraTt4KnkXogmlZ4qavF+8vvsVlnf+4wzuM8Fftyo8YT1n61xgvQuk2y5Zo88i960aiLEJUZgDoZeqF/KKd3bxmAE0tYs9pdYMfBOi2FHwaXJEzjPDzvUfgIBs1W4AxYhClSeAZ7trj3N5mBPYh0BDh3JhUOJsTNb+p59yqkQHcTxmK7fknnoMlghA/EMGSTPuaHRO0mGG1Z27+C6UYDz3Xaq/h66GP4QdWWhL4sqcKbi7u4shzQ3O4DdaC05ogCT5B5AJxAAi8HjzhkKzzwItZGHlKpPNNLbgHpX9Uu/4nc8HwY/NqFhlRj7lXzk0Sh0drymTCYXpVuMHmUASHwYufy7XBRaCPBhXLG3qpUOXJLtUdkhJXrrYg5LZynWHpBHjrI8jv85io7+mVoXPb8ALGtPfVo8iSzDnhJwKxLNYSU5o8pj99tspahRlJOVufJYc6sqo6XBrPMG94qPbxXI2ET+E6Zn7U8cHSBUAlbc8e/98UEzC06JVaMglnmBNmU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YktVYmhrSHV6NS9TVk4yVXI5VFloVHNDRnB0aVZONk9Nd3pIbmN4ak9MN3NV?=
 =?utf-8?B?ZjRjZytvNDJmbW5JRkJjODZLVWdZNmVhYWpjUWZnWUN1ZVdCRGNyUm5YdGpH?=
 =?utf-8?B?eUoxL1YzT3lrMCtpVkpTVjhIOUM0UFg3WXA0ZjBoQkxHM3NSNnhSTHRpNHBQ?=
 =?utf-8?B?a0lNWjBicnBVQXRtOS8wYXVndnZkc1g2U25zZnJ1YmlUZU55QTQ4cXpiY3RQ?=
 =?utf-8?B?Q0F5djhiVXBUTlFjT2ZpMGRsMG03dm1JNnZ5NnRqRmxUMkZxMm4vbHg2a2RW?=
 =?utf-8?B?VE16dkN1ZjVSc0I3YjhjeDNJRC9hdm85OFB5cUhKaW5oWWFPb1hxbldUR0lu?=
 =?utf-8?B?eEhUazFCbGZsTk1FK1ZhV1BJQmJOYUtwK1Jvb3ZwR1RlVGJFZDRIaUJ4cGdh?=
 =?utf-8?B?UGg3N0pYNUU5MDBGK0k4UE5DcXNqTEZQZU8wNk53WTJzdDlUNUNMczZaTHNo?=
 =?utf-8?B?S0ZPWklVL0xiVnFTQWd1c0M4SGxCVzVWTUJJT2tObm9ZMUFhb2ZBRmF6OVZG?=
 =?utf-8?B?bitRRDRKU0toeXZqb0FjQ2lkeVNIQlA5T2JLRHB6RVZUVGF4emFpTUNENTBq?=
 =?utf-8?B?YTBVVlRIS2UrZUF0SnlOVlNtLy9YeVBSRFVIb3YxSGl1WUdBUnVhcjVKLzFL?=
 =?utf-8?B?Y3FiVHV6U1NwOFZnQ3ZIaWtHSytjSkREOWZKYVFjVHNxVXAzNXFOUEM0SGpy?=
 =?utf-8?B?aGhRMFJIRDZleXdQYmFwamlocGttbG9HU2FmOUFnYm9TbGNIYnFkeElPTWh2?=
 =?utf-8?B?QXhDNldYdnBjWlFSZjh6OHVDZTczYU5Fblc2bk1sZ0VHMFlmOUNNcVl2QnlT?=
 =?utf-8?B?azZPQ2FvdW40cHRkUWJYQTJsaDhIUThPdHFDRy9xenE1cGV0MDBhY0pwMDY3?=
 =?utf-8?B?VjFOR2d2NnNraHhuQXVzRzBTRUNmRkhhMG9aT3VYTjJaeVFnVWlvYUJoS0ta?=
 =?utf-8?B?Qy9mSDlzQjJLcTFIclY0MWhwYXBtWEJnNWFDY3pDbGxTSXdoZEpNdlpnNWhS?=
 =?utf-8?B?eEthWExDWXhBVVFLd0NONS90VnFGZ3pkWkVPeUhXd3MwV1dqSVZpM0o5aXBi?=
 =?utf-8?B?Rm9DQko2UUdVZ3FZMjBiZ1VQdS9rTk9vSGhreGl1OE5JY1g4NGpVdVNkM04x?=
 =?utf-8?B?OVRPWEFmSUlWM0ZtVGpBQzM4OXEydTRmT2JPYTQyOFhtRzg5Y3ViMUl3dkNV?=
 =?utf-8?B?NnBYN3dndml1cVBUUFRCWnJEZWQzVm5JKzBIZDRKN2h2RVA2dk9qcUZ2OCs3?=
 =?utf-8?B?QnRTM0ZMKy9DN25JLytKbENwcEE4SnUxVnpxVjdqdmVENXNlOXg3TlZzYWx3?=
 =?utf-8?B?Kzg5dVNzQVplMVgybXNrZEgrSUpkN3lDK2taZDd6ejEvT2FONC9iOE54L2Ew?=
 =?utf-8?B?VnNVT0lPUFNSTS9xVnJiYmhuTWZPUW5uTHF0aDNJZ3BzU3JWN1F5eDg3SkZn?=
 =?utf-8?B?SnBGUnU1R3A2aUN5ZUtCdlk0eW8rNTJheXNNNjIvbTJzUmZxNng1eUJFTHM3?=
 =?utf-8?B?QnpMVEw2V1pPM3IrYXlXT0xKOE5BckhuSEFMK2lBNlp2QWpTRmI4VHRPN0hD?=
 =?utf-8?B?cDdzNFBBREgvU0xPaW9XR3A4NDhGeEt0d2tVTGVzSkJoZjZTMEJZSU9DSWU0?=
 =?utf-8?B?SmsvWXIzR2hCbXJJWk5vSS9RVTArSFFxOS9GbllHdG1qbDNXWXJOUFYvUGI5?=
 =?utf-8?B?K1M0TnR2enZzdFRWOFdwdFNNSGJRZkkrZEhudzc1Tk5KVU1JSTNNZHZBblQz?=
 =?utf-8?B?blBMeFpKUVFqN01xWlVDVXAxTmlmS3NsdHlUSDVaUmJUV2RiM2JBYkgrK2RH?=
 =?utf-8?B?Q2p6Wkd0dmE3LzZPQUorR05hRUMxczR5TTNsSkVHWEtKN252ZmRDbmhmeWYw?=
 =?utf-8?B?aHdYck44WUVTNlQwdjJOaU82enJKTmhxVlhaM2VUZC9oTlpMYjRvWGJMNjZo?=
 =?utf-8?B?STdzYTU3RllRRkpENmlod2RRK0JoZ20remhuUEowS2VxZ3kyMGFSMXo4bFpz?=
 =?utf-8?B?OCs5YWlobC9LNUVPQ1VYRkczNlRqbW1RWEJFNXB0Q2VQWUc3Z1FhM0VCczlE?=
 =?utf-8?B?dDZJeDBWUmhkVk9DdlJqZGR0VVQ5M2ZaRlZ1bjZmNGFiUkFhemJWaWRtbDhR?=
 =?utf-8?B?T2taYXFZcmM4a1IzTlNidXVrc1VPZlJZSDFiRXdCRjB4MkJScnVsT3p2RXBE?=
 =?utf-8?B?VmFkZ01Kd2ZtMGkrSUNkRE9xTVdHRFpleWhxWUJ3YlRybkltM0VweGllcDF5?=
 =?utf-8?B?TEpLUXQwSVNVcy90blliclVZSmdXSks0RnRRVXVqaGtHRm5ndmhobGxSRVhl?=
 =?utf-8?B?b2FQczV5Tjc4Yjc1WC9NUUVtVUJxaTJsMHZNNEdNZEJQTmhRVXlpSExjdGZS?=
 =?utf-8?Q?m5BTmXyHpLyWTIv0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <119464FEE3A9C64F9CD76023BB03659D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kCG+dVER79fdiUwmGbetyG6n2x/VXVPftKxUT6bdicDYKv/z2xuOYt83KXyT2zGY9iuLDCkfYC80t6RYLE6jIJd+kOfW5g5HDJ9VQ6VbAINLg883Jzk8v1lBCPi6qlnM/znwF0BPWfO3tf5L1TO5pdu3eLJHTtCTOBheiL6I0QwSeKfCT5CiVu7XGlnbtjWnxgYDUk7C2v+g/pMNHX3deaL9zgj0y0MN4sF6rW3h1rP8lNmBDJXaBb3p7P7YpH8Sqp9U84hgoEZQxMWZY7JNZs8hxTcm/sMMUjKiZZKYigo7eqSiUKs1qfr+yUuervv/qDAiUFzfekEcCq+VKWcqzA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1770d39-91b5-44dd-a1c0-08de9048d0d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 23:45:54.8213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aimvg9YSPWNWvrfzfCqVdeGO/qreNIP+Rr7Ue0fm2roeHewlQ6sogB5QkS2/wMGh9X+9tTwLNZcsczQWINlBQm8iBYtrOWDDgWNHXwvgx/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6164
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE0OjE0ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gPiDC
oMKgCQkJCQkJwqDCoMKgwqDCoMKgIHU2NCBuZXdfc3B0ZSkNCj4gPiDCoCB7DQo+ID4gKwlzdHJ1
Y3Qga3ZtX21tdV9wYWdlICpzcCA9IHNwdGVwX3RvX3NwKHJjdV9kZXJlZmVyZW5jZShpdGVyLQ0K
PiA+ID5zcHRlcCkpOw0KPiA+IMKgwqAJaW50IHJldDsNCj4gPiDCoCANCj4gPiDCoMKgCWxvY2tk
ZXBfYXNzZXJ0X2hlbGRfcmVhZCgma3ZtLT5tbXVfbG9jayk7DQo+ID4gwqAgDQo+ID4gLQlyZXQg
PSBfX3RkcF9tbXVfc2V0X3NwdGVfYXRvbWljKGt2bSwgaXRlciwgbmV3X3NwdGUpOw0KPiA+ICsJ
LyogS1ZNIHNob3VsZCBuZXZlciBmcmVlemUgU1BURXMgdXNpbmcgaGlnaGVyIGxldmVsIEFQSXMu
ICovDQo+ICJoaWdoZXIgbGV2ZWwgQVBJIiBpcyBhbWJpZ3VvdXMuIGUuZy4ga3ZtX3RkcF9tbXVf
d3JpdGVfc3B0ZV9hdG9taWMoKSBhbGxvd3MNCj4gbmV3X3NwdGUgdG8gYmUgRlJPWkVOX1NQVEUu
DQoNClllYSB5b3UgYXJlIHJpZ2h0LiBJdCBmZWx0IHRvbyBmdXp6eSBidXQgSSBjb3VsZG4ndCB0
aGluayBvZiBhIGJldHRlciB3b3JkLg0KDQo+IA0KPiBXaGF0IGFib3V0IGp1c3QgImNhbGxlcnMg
b2YgdGRwX21tdV9zZXRfc3B0ZV9hdG9taWMoKSBzaG91bGQgbm90IGZyZWV6ZSBTUFRFcw0KPiBk
aXJlY3RseSI/DQoNClN1cmUuDQoNCj4gDQo+ID4gKwlLVk1fTU1VX1dBUk5fT04oaXNfZnJvemVu
X3NwdGUobmV3X3NwdGUpKTsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogVGVtcG9yYXJpbHkg
ZnJlZXplIHRoZSBTUFRFIHVudGlsIHRoZSBleHRlcm5hbCBQVEUgb3BlcmF0aW9uIGhhcw0KPiA+
ICsJICogY29tcGxldGVkICh1bmxlc3MgdGhlIG5ldyBTUFRFIGl0c2VsZiB3aWxsIGJlIGZyb3pl
biksIGUuZy4gc28NCj4gPiB0aGF0DQo+ID4gKwkgKiBjb25jdXJyZW50IGZhdWx0cyBkb24ndCBh
dHRlbXB0IHRvIGluc3RhbGwgYSBjaGlsZCBQVEUgaW4gdGhlDQo+ID4gKwkgKiBleHRlcm5hbCBw
YWdlIHRhYmxlIGJlZm9yZSB0aGUgcGFyZW50IFBURSBoYXMgYmVlbiB3cml0dGVuLCBvcg0KPiA+
IHRyeQ0KPiA+ICsJICogdG8gcmUtaW5zdGFsbCBhIHBhZ2UgdGFibGUgYmVmb3JlIHRoZSBvbGQg
b25lIHdhcyByZW1vdmVkLg0KPiA+ICsJICovDQo+ID4gKwlpZiAoaXNfbWlycm9yX3NwdGVwKGl0
ZXItPnNwdGVwKSkNCj4gPiArCQlyZXQgPSBfX3RkcF9tbXVfc2V0X3NwdGVfYXRvbWljKGt2bSwg
aXRlciwgRlJPWkVOX1NQVEUpOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJldCA9IF9fdGRwX21tdV9z
ZXRfc3B0ZV9hdG9taWMoa3ZtLCBpdGVyLCBuZXdfc3B0ZSk7DQo+ID4gwqDCoAlpZiAocmV0KQ0K
PiA+IMKgwqAJCXJldHVybiByZXQ7DQo+ID4gwqAgDQo+ID4gLQloYW5kbGVfY2hhbmdlZF9zcHRl
KGt2bSwgaXRlci0+YXNfaWQsIGl0ZXItPmdmbiwgaXRlci0+b2xkX3NwdGUsDQo+ID4gLQkJCcKg
wqDCoCBuZXdfc3B0ZSwgaXRlci0+bGV2ZWwsIHRydWUpOw0KPiA+ICsJcmV0ID0gX19oYW5kbGVf
Y2hhbmdlZF9zcHRlKGt2bSwgc3AsIGl0ZXItPmdmbiwgaXRlci0+b2xkX3NwdGUsDQo+ID4gKwkJ
CQnCoMKgwqAgbmV3X3NwdGUsIGl0ZXItPmxldmVsLCB0cnVlKTsNCj4gDQo+IFdoYXQgYWJvdXQg
YWRkaW5nIGEgY29tbWVudCBmb3IgdGhlIHRyaWNreSBwYXJ0IGZvciB0aGUgbWlycm9yIHBhZ2Ug
dGFibGU6DQo+IHdoaWxlIG5ld19zcHRlIGlzIHNldCB0byBGUk9aRU5fU1BURSBpbiB0aGUgYWJv
dmUgX190ZHBfbW11X3NldF9zcHRlX2F0b21pYygpDQoNCllvdSBtZWFudCBpdCBzZXRzIGl0ZXIt
PnNwdGVwIEkgdGhpbmsuDQoNCj4gZm9yIGZyZWV6aW5nIHRoZSBtaXJyb3IgcGFnZSB0YWJsZSwg
dGhlIG9yaWdpbmFsIG5ld19zcHRlIGZyb20gdGhlIGNhbGxlciBvZg0KPiB0ZHBfbW11X3NldF9z
cHRlX2F0b21pYygpIGlzIHBhc3NlZCB0byBfX2hhbmRsZV9jaGFuZ2VkX3NwdGUoKSBpbiBvcmRl
ciB0bw0KPiBwcm9wZXJseSB1cGRhdGUgc3RhdGlzdGljcyBhbmQgcHJvcGFnYXRlIHRvIHRoZSBl
eHRlcm5hbCBwYWdlIHRhYmxlLg0KDQpuZXdfc3B0ZSB3YXMgYWxyZWFkeSBwYXNzZWQgaW4uIFdo
YXQgY2hhbmdlZD8gWW91IG1lYW4gdGhhdA0KX190ZHBfbW11X3NldF9zcHRlX2F0b21pYygpIHNl
dHMgaXRlci0+c3B0ZXAgYW5kIGRvZXNuJ3QgdXBkYXRlIG5ld19zcHRlPyBJZiBzbw0KSSdtIG5v
dCBzdXJlIGlmIGl0IHRocmVzaG9sZCBURFAgTU1VLg0KDQo+IA0KPiA+IC0JcmV0dXJuIDA7DQo+
ID4gKwkvKg0KPiA+ICsJICogVW5mcmVlemUgdGhlIG1pcnJvciBTUFRFLsKgIElmIHVwZGF0aW5n
IHRoZSBleHRlcm5hbCBTUFRFIGZhaWxlZCwNCj4gPiArCSAqIHJlc3RvcmUgdGhlIG9sZCBTUFRF
IHNvIHRoYXQgdGhlIFNQVEUgaXNuJ3QgZnJvemVuIGluDQo+ID4gcGVycGV0dWl0eSwNCj4gPiAr
CSAqIG90aGVyd2lzZSBzZXQgdGhlIG1pcnJvciBTUFRFIHRvIHRoZSBuZXcgZGVzaXJlZCB2YWx1
ZS4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKGlzX21pcnJvcl9zcHRlcChpdGVyLT5zcHRlcCkpIHsN
Cj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlfX2t2bV90ZHBfbW11X3dyaXRlX3NwdGUoaXRlci0+
c3B0ZXAsIGl0ZXItDQo+ID4gPm9sZF9zcHRlKTsNCj4gPiArCQllbHNlDQo+ID4gKwkJCV9fa3Zt
X3RkcF9tbXVfd3JpdGVfc3B0ZShpdGVyLT5zcHRlcCwgbmV3X3NwdGUpOw0KPiA+ICsJfSBlbHNl
IHsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIEJ1ZyB0aGUgVk0gaWYgaGFuZGxpbmcgdGhlIGNoYW5n
ZSBmYWlsZWQsIGFzIGZhaWx1cmUgaXMNCj4gPiBvbmx5DQo+ID4gKwkJICogYWxsb3dlZCBpZiBL
Vk0gY291bGRuJ3QgdXBkYXRlIHRoZSBleHRlcm5hbCBTUFRFLg0KPiA+ICsJCSAqLw0KPiA+ICsJ
CUtWTV9CVUdfT04ocmV0LCBrdm0pOw0KPiA+ICsJfQ0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiDC
oCB9DQo+ID4gwqAgDQo+ID4gwqAgLyoNCj4gPiBAQCAtNzM4LDYgKzc1OSw4IEBAIHN0YXRpYyBp
bmxpbmUgaW50IF9fbXVzdF9jaGVjaw0KPiA+IHRkcF9tbXVfc2V0X3NwdGVfYXRvbWljKHN0cnVj
dCBrdm0gKmt2bSwNCj4gPiDCoCBzdGF0aWMgdTY0IHRkcF9tbXVfc2V0X3NwdGUoc3RydWN0IGt2
bSAqa3ZtLCBpbnQgYXNfaWQsIHRkcF9wdGVwX3Qgc3B0ZXAsDQo+ID4gwqDCoAkJCcKgwqDCoCB1
NjQgb2xkX3NwdGUsIHU2NCBuZXdfc3B0ZSwgZ2ZuX3QgZ2ZuLCBpbnQNCj4gPiBsZXZlbCkNCj4g
PiDCoCB7DQo+ID4gKwlzdHJ1Y3Qga3ZtX21tdV9wYWdlICpzcCA9IHNwdGVwX3RvX3NwKHJjdV9k
ZXJlZmVyZW5jZShzcHRlcCkpOw0KPiA+ICsNCj4gPiDCoMKgCWxvY2tkZXBfYXNzZXJ0X2hlbGRf
d3JpdGUoJmt2bS0+bW11X2xvY2spOw0KPiA+IMKgIA0KPiA+IMKgwqAJLyoNCj4gPiBAQCAtNzUx
LDcgKzc3NCw3IEBAIHN0YXRpYyB1NjQgdGRwX21tdV9zZXRfc3B0ZShzdHJ1Y3Qga3ZtICprdm0s
IGludCBhc19pZCwNCj4gPiB0ZHBfcHRlcF90IHNwdGVwLA0KPiA+IMKgIA0KPiA+IMKgwqAJb2xk
X3NwdGUgPSBrdm1fdGRwX21tdV93cml0ZV9zcHRlKHNwdGVwLCBvbGRfc3B0ZSwgbmV3X3NwdGUs
DQo+ID4gbGV2ZWwpOw0KPiA+IMKgIA0KPiA+IC0JaGFuZGxlX2NoYW5nZWRfc3B0ZShrdm0sIGFz
X2lkLCBnZm4sIG9sZF9zcHRlLCBuZXdfc3B0ZSwgbGV2ZWwsDQo+ID4gZmFsc2UpOw0KPiA+ICsJ
aGFuZGxlX2NoYW5nZWRfc3B0ZShrdm0sIHNwLCBnZm4sIG9sZF9zcHRlLCBuZXdfc3B0ZSwgbGV2
ZWwsDQo+ID4gZmFsc2UpOw0KPiA+IMKgIA0KPiA+IMKgwqAJLyoNCj4gPiDCoMKgCSAqIFVzZXJz
IHRoYXQgZG8gbm9uLWF0b21pYyBzZXR0aW5nIG9mIFBURXMgZG9uJ3Qgb3BlcmF0ZSBvbiBtaXJy
b3INCj4gPiBAQCAtMTM3Myw2ICsxMzk2LDkgQEAgc3RhdGljIHZvaWQga3ZtX3RkcF9tbXVfYWdl
X3NwdGUoc3RydWN0IGt2bSAqa3ZtLA0KPiA+IHN0cnVjdCB0ZHBfaXRlciAqaXRlcikNCj4gPiDC
oCB7DQo+ID4gwqDCoAl1NjQgbmV3X3NwdGU7DQo+ID4gwqAgDQo+ID4gKwlpZiAoV0FSTl9PTl9P
TkNFKGlzX21pcnJvcl9zcHRlcChpdGVyLT5zcHRlcCkpKQ0KPiA+ICsJCXJldHVybjsNCj4gPiAr
DQo+IEFkZCBhIGNvbW1lbnQgZm9yIHdoeSBtaXJyb3IgcGFnZSB0YWJsZSBpcyBub3QgZXhwZWN0
ZWQgaGVyZT8NCg0KRWhoLCBtYXliZS4gVGhpbmtpbmcgYWJvdXQgd2hhdCB0byBwdXQuLi4gVGhl
IHdhcm5pbmcgaXMga2luZCBvZiBjaGVhdGluZyBhDQpsaXR0bGUgYml0IG9uIHRoZSBpZGVhIG9m
IHRoZSBwYXRjaDogdG8gZm9yd2FyZCBhbGwgY2hhbmdlcyB0aHJvdWdoIGxpbWl0ZWQgb3BzDQpp
biBhIGNlbnRyYWwgcGxhY2UsIHN1Y2ggdGhhdCB3ZSBkb24ndCBoYXZlIFREWCBzcGVjaWZpY3Mg
ZW5jb2RlZCBpbiBjb3JlIE1NVS4NClRyeWluZyB0byBmb3J3YXJkIHRoaXMgdGhyb3VnaCBwcm9w
ZXJseSB3b3VsZCByZXN1bHQgaW4gbW9yZSBidXJkZW4gdG8gdGhlIFREUA0KTU1VLCBzbyB0aGF0
J3Mgbm90IHRoZSByaWdodCBhbnN3ZXIgZWl0aGVyLg0KDQoiTWlycm9yIFREUCBkb2Vzbid0IHN1
cHBvcnQgUFRFIGFnaW5nIiBpcyBhIHByZXR0eSBvYnZpb3VzIGNvbW1lbnQuIEknbSBmaW5lDQpq
dXN0IGxlYXZpbmcgaXQgd2l0aG91dCBjb21tZW50LCBidXQgSSBjYW4gYWRkIHNvbWV0aGluZyBs
aWtlIHRoYXQuIE9yIGRvIHlvdQ0KaGF2ZSBhbm90aGVyIHN1Z2dlc3Rpb24/DQoNCj4gDQo+IEFu
ZCBkbyB3ZSBuZWVkIGEgc2ltaWxhciBXQVJOX09OX09OQ0UoKSBpbiBrdm1fdGRwX21tdV9jbGVh
cl9kaXJ0eV9wdF9tYXNrZWQoKQ0KPiBvciBjbGVhcl9kaXJ0eV9wdF9tYXNrZWQoKT8NCg0KTm90
aGluZyBjaGFuZ2VzIGZvciB0aG9zZSBpbiB0aGlzIHBhdGNoIHRob3VnaD8gRm9yIHRoZSBrdm1f
dGRwX21tdV9hZ2Vfc3B0ZSgpDQpjYXNlLCB3YXJuaW5nIGNvdmVyYWdlIGlzIHJlbW92ZWQgaW4g
dGhpcyBwYXRjaC4NCg0KPiANCj4gPiDCoMKgCWlmIChzcHRlX2FkX2VuYWJsZWQoaXRlci0+b2xk
X3NwdGUpKSB7DQo+ID4gwqDCoAkJaXRlci0+b2xkX3NwdGUgPSB0ZHBfbW11X2NsZWFyX3NwdGVf
Yml0c19hdG9taWMoaXRlci0NCj4gPiA+c3B0ZXAsDQo+ID4gwqDCoAkJCQkJCQkJc2hhZG93X2Fj
Y2UNCj4gPiBzc2VkX21hc2spOw0KPiA+IC0tIA0KPiA+IDIuNTMuMA0KDQo=
