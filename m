Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6E3C8C71;
	Thu, 13 Aug 2026 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786664509; cv=fail; b=qlL1NMWUahvAHU3iQFH6IFoGCWUxms2xTqmGEKS+p0CZCk9OLh3Fnz+Oky3H5+6GlL1/rJRXwzQQIbeoktDLAfhyqSVYdsAGY+LxmekFjxUq8TGMTNB7d1/XV7TYRic2dG72GNSNX2TvZq+BoZIt5nc7c/CfE4WPh26ulB9e0bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786664509; c=relaxed/simple;
	bh=P98JlSlciYdYEs/8K5ovXQ2Z70MCZEJs9IgJ4SUq2pA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d7/HCFtPcMexI3e/KMQb3EnAT92R3viou6XuizVO43E9DxJJRajUONTQLLubX4IHXuCs/Usp7zA4PbyxyM9erpPVGHl4IhEb5pCNlPyecFbaK34EZHy0Hy+wPk3OlqChxUJZ4bXKrmNrUjll29vTbB3Q17ik5HkapuoGFF/2LYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZi+J/EF; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZi+J/EF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786664508; x=1818200508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P98JlSlciYdYEs/8K5ovXQ2Z70MCZEJs9IgJ4SUq2pA=;
  b=FZi+J/EF7mm/c6GRjot3mMLS4614ZQ7umAiL0r0AtJsubMhMH4dDAewu
   7YhQVXgkX3Ax8KM/VfM+o1Gk7dDrKWAvF81qe9gWrjtcwnfrvRfYtJ2Al
   W8Nfi4U15ixAz46gm83cO/zLEpFC4twFJ5Cx1vwBkgOQVQOHhhlgoBULS
   g0l5frgt3kFflS478dice/YdboJbJx1vZTV/Tn419Gi7nhvn5DhlyqrI/
   iq6hdvhDp9QvJbJuxx7u9AJQcJxQ5qXQ7WZD7Ny9a+LHnYZDZtUvjjMMk
   iC/blNkyZem6pFTGyHWyAQdvD8W/A7veKuHhnCF/whWNExd7+SrMBq1CR
   g==;
X-CSE-ConnectionGUID: ufL5SXZnSSiA9+AfPsxZLA==
X-CSE-MsgGUID: hSuhJCosSQ2tdz/ZTtFu8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="91123414"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="91123414"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 16:41:48 -0700
X-CSE-ConnectionGUID: Ubdd4uZqR4GG/wpEhEdGVw==
X-CSE-MsgGUID: mzef98/5QqK9hecks6T/Qw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 16:41:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 16:41:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 16:41:46 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 16:41:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sETz1MetF+Xnt0OQTPOOJhCDu8U2j68Eoe70DwNBL125WYEoQ2pLM2CswVxMN6/UCtsHTf2fIqPQ8Q3XqTHaxXvnXZ87TAadAd2Q4uxDVYuC2ZoyG2J+XwvXQ2pB0kbUS5UeuiVxDREcpoUyfZIYdg+gs0BmHqQnTOtzpvDPI3C93WKVlYiT+9HoWELhfoFhE0NKHlkDU+xP7D0s39d2qW6XEFyCHswUvVxqpaua+lsw6Z+x4syZ0x0rntS88Ep8pouMSNN0mtI8kM8FqsMMjJ54CSP3IDcduv6SwbJFfqhWhVRGwzeeKehfGp9ak2ihgyEeT/86rRGtABJnVDSfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P98JlSlciYdYEs/8K5ovXQ2Z70MCZEJs9IgJ4SUq2pA=;
 b=K6hvmDe0mSgT2ZIB/5wClsqwT2l3sq9eW+L5R0Z/7PnDGpV7Ya6HQ1EnZu2WhRZJqVTmaDjafEQnygPLiwseMQW1EFq8caWtRgEJfneYU6wpQUYrhz0ZSyFK9wGvDyJPSg/AjbHKjnqtOYfkxpRdbOXBj7vrcRtBqc1asbl0YkroXaa8taQdZRz18IOja46NHpn/76Wn9BE7nBGC89xfVJyNKK/dNznTvM6dAAQkJI2A+Had1/OiLopqWRlADcDHhUCwA6dsETh1zsqOfOh6BZlZCC2jtzdrXT7u/qi6oN07GTzlSuGcIi8jwuG8SFdLjKBPIYsdMdyifZaG0d2Pfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 23:41:41 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 23:41:40 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Aktas, Erdem" <erdemaktas@google.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>, "ackerleytng@google.com"
	<ackerleytng@google.com>, "pratikrajesh.sampat@amd.com"
	<pratikrajesh.sampat@amd.com>, "oupton@kernel.org" <oupton@kernel.org>,
	"wyihan@google.com" <wyihan@google.com>, "sagis@google.com"
	<sagis@google.com>, "Wang, Roger" <runanwang@google.com>, "Gao, Chao"
	<chao.gao@intel.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 03/22] KVM: selftests: Initialize the TDX VM
Thread-Topic: [PATCH v14 03/22] KVM: selftests: Initialize the TDX VM
Thread-Index: AQHdGi/cVkGz/cpvWE+Eu6EInG6oT7Z6ynkAgCH7uYA=
Date: Thu, 13 Aug 2026 23:41:40 +0000
Message-ID: <52fa4033cd3ccc4caf0bfd46fccca0bc8aac0dfa.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
	 <20260722-tdx-selftests-v14-3-15ad654a50db@google.com>
	 <c8b7a800-58ed-4ef7-91bd-31da77763717@intel.com>
In-Reply-To: <c8b7a800-58ed-4ef7-91bd-31da77763717@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7529:EE_
x-ms-office365-filtering-correlation-id: 429093fc-1ea1-4bdc-045a-08def9946ccc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|22082099003|18002099003|38070700021|11063799006|4143699003|56012099006|10067099003;
x-microsoft-antispam-message-info: WmT3YZriEDJdjbUKgMsZstP/FDFDAvXWJ9ASH72FSxc0250MRint4SCSv9dHJIyTv9RSAf1XnsXAwnABBVyFlBHtCq6P2E3y2w406NvQ2zVl4moBHyVgKkLJ849V7rSqF2RhDlrIrgb3LM05mXDWJsu4iF//VpM274A2JmDAzoKCtZdgKZYUBVcxIrmb4Xc9TAeeAXxW1fk+uIDLNXYekBY3R9MVb6aENTYYqQuDCzYLjdFPBIA3U1vsuWU89GviiKAnjgbjUkRxalUulpkrJeMSTzIScHeQ+EmDidKwy/szZhXNUfJPt0V+7MAYgdPMS3wC9Gm+q9x80F4Ox4o5X5abp+d4lDBmja0BBODjw9FEfIuDkaARx20JBcNoMxP78f45/cP7Ckbt3LcXz3Ww5oaoFMK4KdMjHE02AztQUW0/aGHNyo8E6CKl1DZMXsWuuqork7I9+xy4BPNgEscAFyQJrjXi5VYgj3mZI0PskcDvLuu27O6NbJRBGLtSdYlKNOqXNnHaqVolWvDttM20UXLvo58Kqllxk6Sel5+WWmjMj20bXa5VkDCUgW5s7CmoN+A05g52Ip18q5iNIZ5W1pTz6M2sxZx4ke1PqEoE33O6I+kXzTESnIBRP+4s4FaJ1kivAWmMv96V9L0Ae3Mo1+OSHyH/4PW6yjU+T7tZVcwLKWROqCPw+HIVIHDDUYKL6KbP7kArn4nEzsTmDi0VdO0IKRyAJcU9FeUeY9wigHdv0roQ70vps0GaVI7uyNWR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmZadml0NEJCdW5zaGYvYXVzYmE1Q1VTMElZQmZ0MEs5OHgyY3gvQjQzd0lm?=
 =?utf-8?B?ZXJRLzNXdXZ5OFdCNU43aDZNTGQvZ21yZ1ViVW11T3FBbXgxekZtRDNRT0FU?=
 =?utf-8?B?QTJvUm1GNG4rd1YxRkRRRXlGN3VFaW5pemhhcjJnVWNRUnJwbjBhOUxjczVN?=
 =?utf-8?B?ZUZETG1ERXAvQ09QYTJqT3JPYTVYVHlzSGNPbGN5QXNkaWg1VmJUZVN6cGRo?=
 =?utf-8?B?eVIyaFB6QVFrNkZSbHFlRm5BdG92Tm5iYVlBTDlhK1BjSFBSN2o2Zmd3RUZY?=
 =?utf-8?B?M2xLOTVCUW9iMnBPYUJEM2ZIVWZ4SWxmQlMvMlRIQ2krNDZ3aW5zV3kvcTdU?=
 =?utf-8?B?eGs5OEhEQ241bUc4ck11TzVDVlRWSDBVV0R0TEtieHRYMGdUYUJ3VHNvMzhP?=
 =?utf-8?B?UjUxSXB1d21UL2Nvb3ZYd3lNWXYzQjh1b0tXZ0NydlgzcTJHTlVXZ0UzVzVX?=
 =?utf-8?B?NVFWR25aMHlHUldKRHRDOWtQT0hHVjZZbDZaN3VCODgwY2tnWnU3Nm9QTDVw?=
 =?utf-8?B?ajNnSHZDVWZvZ0pnMDZzZlV4NUg1cFNQRU1XMjc0Q1c1a0FlT2JlY1N3enZj?=
 =?utf-8?B?d1pSK2Fyb1pTa0N2RmdDSkxXaGIrcjFnS0tUVkU1VWxzZElnUHY0VU9xRHZ5?=
 =?utf-8?B?dXVjZHBlNWlSRUJPRVpKcVpobXZLMjl1QnlOS3NOM0VKQzlGLzVQbjhlTzIr?=
 =?utf-8?B?MHN1eVhQK090YVFpNnJmVW5Ma09Ld3ppZkw3R3E3THVlSFh1dmVhMHJueW5j?=
 =?utf-8?B?c2R6djJneStna3pTNkoxRURhU3dXZTRsdktEOVFudHgwMTloQXdaVnFVT1VN?=
 =?utf-8?B?eTR3WTMyYW9sR1YwTmtBd2pBV0phRE81bjFyMVhyY1c4L3I5Sk1aRmxoV2pB?=
 =?utf-8?B?SldFcWVtUXBTOHVwNVRpbXBkejJJY1g1RW1QRGtSejhZb0MwejM3RERvV0VU?=
 =?utf-8?B?bzdPbWJxcmhFNyt2YkpJZ0VkR2tVTE9CSmYrQjE1aEpzR1RiQVlRczZpK2p1?=
 =?utf-8?B?cWwrYWtWRzR5WmtCdGwvanRwMGxMUVhCSHFZWlk3Z0w2aFVCbTVZSHdncitG?=
 =?utf-8?B?VlZRb2NoNTA2Zmt1ZHVhSGE1MUVIUHJ3NEI5QWRPaDRNamYrNktPQkdxWE53?=
 =?utf-8?B?RE91WGZVVFppVGNFRER3cElDbEZvWDRvWkxBUTh2RG9wb1IvMTdrZWc2T20w?=
 =?utf-8?B?NjE3eU9FbTA0OUR6bmVzS1pxUk5ENTJWOHJBMFUvK3BucHNNRnFiMG90QmNn?=
 =?utf-8?B?UmxOMlkwQ0ZCZEk1TExsY1NRaWJGRitxNXFvbHI4bU84RjRUcE5JMUhtWmxh?=
 =?utf-8?B?Q0ZtTVkwdHhoSTFEdSsxeERHWFhOUzZRUDZHeXRuSDU2a09WaldUakovdkhh?=
 =?utf-8?B?aWpRRTJHc2xNWkFkR2JLNGpZQVFURC9kVVh4Z2NEZXpaTVpVTmtrRk02dldq?=
 =?utf-8?B?OHh4SU1iYitxZmhsUEU2cFBXejJhdzVZb0xFZG14dWw1ZzdCME9WQWVmOEpa?=
 =?utf-8?B?NFlidS9NaUhmempGRGpWQ0VxWHFLZ0FicVJkTzcyYWgzdWtwTDJwbHJCYnpn?=
 =?utf-8?B?R1lDM1RHTzJHakpwUnV6SEtpK0NLL01OODN0WjNMQStvWitrMnNYT0V6bG4v?=
 =?utf-8?B?cFRTbThIZW1GZStjYk5JVXJSNERHMHRkNmVnMmp2NGZab0g3ZzFkdlZLdkk0?=
 =?utf-8?B?QjZXL2lwdGIwZTlSWHBBN25WTFpYSGU4WUd4MXV6WWxJU2lSdGpYYkxsMWVu?=
 =?utf-8?B?Q3FKbnpJYVZRQ3ArUHhLNUE3TGlnL3ZmSWRmaDhtNVp5b0prc1c0L3R6eTZI?=
 =?utf-8?B?d25Kd2VvUUJWQXJDTVZmQjRva1lQcCtUTnZJOGlEVGlOdmYyV0pUUy9MOVJT?=
 =?utf-8?B?bUFVUlRhL01vQ3IvVHM1K1FHMWszQUVoN1d6ZVdtb2Z0dm0zWnNSSE9TSHZE?=
 =?utf-8?B?ZHl6TUtXS1YvTTRxei9DU0w1dVZFOENlVVREVGVNMDlYdVVSYUs4VG8rUHNi?=
 =?utf-8?B?Skc0UnFFdnVGTWwrVTdHZC9YVFpjTmdOc1B4bng3VG5vZXArN0V0VlJ0NElM?=
 =?utf-8?B?bDhhalVBbkVjY1Rqc0xqRmc0Z28yMGdaVFk5eG1ieXg4eXFsNDhXWjBuZ21Z?=
 =?utf-8?B?T29mNCs5eFBpL0YvWXlYYjBpbnVFT0ZaZjExQmxjRHMzSzZSZkxyZkFaaWtq?=
 =?utf-8?B?V3pUODhHak84VmR6VHZvazBaRGl3eFl4NWlOeGF2YzBUZjFPeE1GeG4yRzY3?=
 =?utf-8?B?aXg2UnJQNkpxbWpkTUZFWmJHaGpxTFd4VEZwMEx4dDFEa0xqd3dvUzlqZWlF?=
 =?utf-8?B?SmFSUy9NMjRYQ0hONFRkQXpDRDNaVCtaRGxYK2lxeHJ3d0N0K0dxUXhCMjgr?=
 =?utf-8?Q?Iz5o3/lqT9ceI2bQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D7789B0C137C5498C2A285673304C6F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DSTvYfjUTLk5t3dDdDRxJS7M3KnXURqJUJmxsyF7HGniWoLjHwmdLwun37ehmSxdvbpDU8G0EBO/Qae1XdGYx+MTTLInSlR6Fl+wR/vFbfdZVU+pwCYb/6AJTg757tYZJIR5B+E7Rn0JnbkRZLaNpSwWzRmkLHxBWBWEmKHGYlTMSAXdhs4pTK4GXYeEZANITuoaXR73rhwBFiCfG3n51ULlji/Vpygp2wWoLtPIrnL1/ipDmhm+8idEDsuOHcww+eGfwZISSMqNiXML27VXIjyapLhU0syu0/vL5F7GY/+75UyjATRJfVy8d5hOEIdiN8VAF206b3x0E74qWff4QA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429093fc-1ea1-4bdc-045a-08def9946ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 23:41:40.8332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SW5CO/KZlq61czmeoGt59kH4ZHM7y/EFl0hlmGPvIiuvyW/WukxnSK6vNszvMtUEgHju6KTWBjILW5wS9PrIlapE8xW7QV/6OoWA/O5yV0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA3LTIzIGF0IDE2OjQ0ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiA+
ICsJaW5pdF92bS0+YXR0cmlidXRlcyA9IGF0dHJpYnV0ZXM7DQo+IA0KPiBCZXNpZGVzIENQVUlE
LCBpdCBvbmx5IGFsbG93cyBhdHRyaWJ1dGVzIHRvIGJlIGNvbmZpZ3VyZSBidXQgbGVhdmUgWEZB
TSANCj4gYXMgMC4gSSB0aGluayB0aGUgY2hhbmdlbG9nIG5lZWRzIHRvIGV4cGxhaW4gd2h5IHdl
IG5lZWQgdG8gY29uZmlndXJlIA0KPiBhdHRyaWJ1dGVzLg0KPiANCj4gVGhlIHJlc3Qgb2YgdGhl
IHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuDQoNCkhvdyBhYm91dCBkaXJlY3RseSBzZXR0aW5nIHhm
YW0gdG8gemVybyBmb3IgY2xhcml0eT8NCg==
