Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AE94779A5;
	Wed,  3 Jun 2026 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487962; cv=fail; b=ikKvKwZ+vbmkD+xVaHVrm+uqYQgED2J3q1LoaLnHj02vRKg99yGJAoHlaQ8icCmqTQNdJEEhN2PJ6Z29fDrtQcPlEUBXAXNLsBh9hoUdhBhd/6U/nwZC5AqPMj51QdCqZxHOTvkusjmXhD+n2MHDmhGWc84FMIw4wWFFaQu3qQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487962; c=relaxed/simple;
	bh=khMP+yJ2P9vfWD8JWAJUAYDx13jeuNZMcEbr271CQBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=px4eP9QuDbEgLkBggOFW0//O0loZCSDFAKodYO8lB0JD/WNKpFbgJPrI0MwCGw9/1AstsPN8AYDhYRnFukHffObpMa+TLsT7YaGqXTJl8/PxlljbE49pMwxUVShVv1jMv+753Aps5auFzZpKMGKdOfeD9AOQCJO7+Zr2nUsapQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3ZcqgoL; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3ZcqgoL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780487962; x=1812023962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=khMP+yJ2P9vfWD8JWAJUAYDx13jeuNZMcEbr271CQBM=;
  b=F3ZcqgoLbOY9xKF4is30/cldeqayEUwh9CJaSDzhGq26rPwIFDD+TRa7
   wjvkFu4CpjELby9zVeltKsjQAEoQ646xT7m3tOPbxGY49a/gikaW4dSyF
   MHKt7PjT4PANctqbW1BT6pOdI4rOMFO2G1CzLwa1XiE3o6Ic/JbwZMxMD
   Ah1OUKdo/LWNkTrlyrC0RTMeqx2RlZYnlVkBmPNEJijN4GO41hqguCaAj
   Vot0SRYlLVENcaRNAxovWBCt9O6ejkBhOhYHNzn+5VzbXpGwkSM6eMwfY
   lTf1ONxrMJlCqh6e4a+jWMkdFWD1ZZZf+M7ernNCC1sajRzz+4niHYV6x
   g==;
X-CSE-ConnectionGUID: Aow/rw2bR8ySRfEAnbjofA==
X-CSE-MsgGUID: AOHWWEcGQ3KE1nWWwtd3aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81475486"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81475486"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:59:21 -0700
X-CSE-ConnectionGUID: wmO+O3aFTb2bnThwDsComg==
X-CSE-MsgGUID: 9GymKqK8QTKd17Ex8nWiZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="246026602"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:59:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:59:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 04:59:19 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.43)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 04:59:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crKLrdUJr5DEAmqOCguem1h0qilSoRGiVzHec9wNa+fEnOdzzMAa56SULi36pWlC/T3wTj3a4kcpCPxRrPR5ohwBzudvgYyHeYhVYCZKtkBl0xAmSEglivZ5QZ++G0JZvuBTGNtwFY8k6a5dHYegum6WOBeT45uX0p0p1Tlk7Pa+Nyd7J2vEHQgreY0OxslNeGejKTNvUUzkw27Ae6R7/wE8Y7R0rm74r/K+ffV5z/7yY+7ITfzHRTOg15xZo1NhUEF5+URw+McbvjgUa32Wl1WkHSVNf54B9NC9Go3i6UhBgzouqhQm0eyzjfH3Jb6P7Q6OA30g054viWt8dqI6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khMP+yJ2P9vfWD8JWAJUAYDx13jeuNZMcEbr271CQBM=;
 b=DQIh+yMUJbxxwj2UQvdqqQYMOjZW8TJYr1BEqWcZs6g3wAQgpVWlr+jAkXg0XTtkHaC7YHNSciGQyQjnrzJEhrI0LE3FJba/jd5aeHD/Jt1hnaPdj7bzs7er/GtMVKJ2zQo7vLhWwh6OI2MAfsW91nkFBkAS9ZLVYBeh1lGcKMLKnkZphMje47sb4UUDe2kiwOHl0B6WMEr8WZQKJZ9uplZPXxyH9YKd7c8wwxDBa3wikjQwq5qpsAlJ/cQK48/1gQchfrP1Pk+k2Xz8Bg9gbxFxBlOnTHWckBMnLBfupYjTbs4GgYJPmKEy0MEUOf2X9sjda5VlVa2AY8MxCkXsww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA4PR11MB8941.namprd11.prod.outlook.com (2603:10b6:208:55d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 3 Jun 2026
 11:59:10 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 11:59:10 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 21/40] KVM: x86: Move eager_page_split to mmu.{c,h}
Thread-Topic: [PATCH v3 21/40] KVM: x86: Move eager_page_split to mmu.{c,h}
Thread-Index: AQHc77nBg2lyQQMns065HTFESzuDOLYswVGA
Date: Wed, 3 Jun 2026 11:59:10 +0000
Message-ID: <12662ee1c1fbe826ce8bfd8876ba7825305e6b44.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-22-seanjc@google.com>
In-Reply-To: <20260529222223.870923-22-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA4PR11MB8941:EE_
x-ms-office365-filtering-correlation-id: d035781b-ba1c-4542-b1c5-08dec167860a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: iaHcMqPuk9sC/bW4nz5jhfoRDdwz5QP2b0aP0mB8ZssdhXZUokAKqfjH5J3H5pfbFb4CMLU0xxDjrjKO0zm3YUDpRYgHCjKpNRXI3JAaUh0vyXpijOsYgKkoMBScoJzIluuP4fmbGBYT7dMxChnRanoAsL5Z8bShW1srB7p/ByADMJCG+A/Hbi9B5kgNBkq4CyD8+M0KYwYsOVYnt9HoxkFIZjJF36+WeVt3gfv3/94xkDFih/GTryTXhZ09lIOY2YYLg+ORw9VmKkR3jdubnd2k6pni90UI3FuyQOfx9aDxftdX7kUOYBlWsbi6AhPo9U8nylkx4+YBF3C2X+LFgnHxQ/AtTCrvZ4wZhm6wu6kDfDvkdOfonlGVsbCnqxNyqgjScDj4/hGIkaypR2W2zzcxBAhjg6b2vMp7gnnJv5ZON0KqvVYYle4UcyXq0qbkdJN3jar5y2TGgUKkPbw8gfYOIkAQXIRdEo3uZ3qfncLd+8GAHrZSNv8izIq0jl8HtvO/adJH2RnnGPVqUnc45DPCKP0T4hYrM9FsC6EvERHWQCN6oGJH8GDYfjW4q+jpXToNblFntfsAhh93OLh5x7nFi6CuHsJbVcFp7vgJMS15y+A0qry8g473mT6CwGAm7dZsMsvQwkDDuvhF3l4uDJEdzXhNloR3aOdYev+WNu2HZpeDwFli2XUSVhvIfA+IRCVTPF521E/T9lZ/WTRWWja0zomEI0EsVGzMdyceHPipQJMNpCfAbXdAQ3IG2ug2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z01rRlIwVE1IRlM4UWoxcDluUnc4QmV3c3dMMFhsZDRaYjF3cExmbnp5NEVI?=
 =?utf-8?B?Q3BvNGEyOVlCUUF2djU5Vktna21MZjF2YlRCVUdTNG0wKzJOQ01UVUEvNzZ6?=
 =?utf-8?B?TzJZOXVBakwvSzA0NFdIOEl0RTNjc09IK0o3T1BRYWhFTStPMU1JQ21JYnYy?=
 =?utf-8?B?MDRaNktvczJ1K3NvWExDY01iMjRkd1JFWWFaQ28xd3YrN2w1cHVZbVd5cmJV?=
 =?utf-8?B?K0FIa3o2eG9VYmYxZnVtNGRXcXUzdnJ4Q1BkK2pQUnZZaWRORU9VVWhyUDJY?=
 =?utf-8?B?VnJ3bjRUTmxlZld3dng4ZDhnb0dSUUkyVEU4S3k4K0lsa1dKUmdkVVZqRTJO?=
 =?utf-8?B?bWVZd3FUbEd1K1Y3OXVGSWt1cWwwMnAreUNSVWR2cEpURWxOeE5vTkNCS2pp?=
 =?utf-8?B?cHdOYnRGQ1Uvd0pUZmpoMHVVMndsOVFPcm0zdk5nWW02d3FBL09jYWNlYW4y?=
 =?utf-8?B?bnB6NWxhcXRWZzNVT05ndGN5aFNZN0hUd2pqaFpiTmpBR3MzR09TbjFrR0Ft?=
 =?utf-8?B?bGxDWmhtbWlDSzNJNVM1dENpRkd3N2hhVTJudXJmbmNHcmZ0R0VFTWlpT243?=
 =?utf-8?B?MmpNSmNlQjlXV1k4Ty9VM05tcG9SRmRZV0pzbC9jODBLNCtuNGl0ZStQN3Nr?=
 =?utf-8?B?c3JOTDZGc3FpYmxoTGxrdStqdEFBVkdZcjFtYVR4S0tBMWJWZmRCMS8rL1Iy?=
 =?utf-8?B?SjRqMnRBR1BDQis4dG01M0JtZ29ONXJobHRXTFRWRmV3Y3Fqb1lVdktPZjJu?=
 =?utf-8?B?c1MzcVNmZ0ZLdDFqMkxiMUZrSXVadjBFczVnek9CSEVIL08rWGtQVmJZbU1u?=
 =?utf-8?B?LzNDYTFYT3dFVUNoR0dsbUVHL09VUHQvRmJPT09pRFgxb3U5VFFua3E0Rzl5?=
 =?utf-8?B?MGE2K05sYlExTnVXQW4vQ2FHcGdKSVlQQ2xFak5ZdVU0cUh5YnpFak9NRUtK?=
 =?utf-8?B?VkxSTG1IY1NXbVYzUlBEZTE0MnFOMCtxSTFQTjZJUTI1R3ZveE9JWUo0bnBQ?=
 =?utf-8?B?MFZPS3d1aUxYSzFMNmRjRS9WUnFOV3ozVi8rRThvVlljRk9zRmJVRGJublFK?=
 =?utf-8?B?ajNDSHJnUXJKck9lcE1YOFFrMklzdVBjeS9iYjFKSjZyVTN0OHB3ZE8xYTZR?=
 =?utf-8?B?UUE0cnFNQW1seGpEd3VyUUI0Ym5rWDlPTmZKVkpOdmJHV0VZaDh6alpSMzho?=
 =?utf-8?B?eTlYRWZ1bmFBWkxSdFRKR0Z2bVo4bFBNRm4zR1FmV25RcVYvSzA0aTRXUnVE?=
 =?utf-8?B?dU5oR1Z3ZkY3MVZkaDJTSFpEa3kwSlQxdlI3S1EraUdRMlhkNWpRTW5RM0JM?=
 =?utf-8?B?a0JPbnJGOXg3bTQ4L09lUFdBa0lYOVExN2EyVFkxejFWL3V1RGgxYjVtRzRl?=
 =?utf-8?B?a2U2dHpFd1FQVS9MQmRhSVhNd1N2N0MyazE1Z2tIcDhqSnRMcWMvQjF5SWc0?=
 =?utf-8?B?dlI4VGdaYVVhSmEyMHZnSkRCbU9yZmE2QXhLVzJpUG0yUlpabmFxNGQzREVr?=
 =?utf-8?B?azdoQnFkUmc2TTRYeEFIbFNZVUkzWnV4MC9YbEMyakhHVS84SFE1aFk5ZjFF?=
 =?utf-8?B?cVVVY1lWRkVudXk0YWVKZ01nSU9XM3ZYdFg5SkE4bWVTclFqZ3NSTnBRdHZI?=
 =?utf-8?B?d2o2UWlLV2dYaG9waGhiVGorR3ZFNUlURDFjK1F5aTBEeGNLS29qU3JrNENC?=
 =?utf-8?B?R0VyTEJ0eE9RaDdrak5vSjF0WndKMWJDa3ZUTVU0M2hpNFNadXFWTFdGMVVU?=
 =?utf-8?B?elRENEZGWkhTejFsS0ViaEZUaXN4QVdvYlJ0TUsrelFPR1l3VVl1K08vWkZU?=
 =?utf-8?B?ZHluOHdGNHBLUVd6WG5iSFh2U1JkUzBzVGlaOTYrUHdwd3RBbzl5MU5ldWdl?=
 =?utf-8?B?OENkNjhab3ZwWFR1VWNEUWpaWFNqZ0FCUTNxZW5sQURidVRNcEUzTGc5MDZS?=
 =?utf-8?B?ZktzcTc5VWRTaExxcGxubEdOVGd4ZE5qM1FORnNIM0Rzb1NjMWxQalBOVDVv?=
 =?utf-8?B?eUhMSkJpRnZQZDhTbFBCaDdtcDFIQTI3ZnZkQWFOczU4K0t4bVR6cEJzQVY2?=
 =?utf-8?B?aEhGdXVBMFRSN2VjdGRjZFNkYVJqcUpwazQ2NWJkUXplTDlCSXRRbmx1QVB4?=
 =?utf-8?B?aDNJVjdCNFNxZ1U1WEl1WWNRUHd0VWV1V0k4L1JsZmZ3NXdNWlNEdEs0Wmp2?=
 =?utf-8?B?NTZib0ZuNDZvS2t0alRMS3RQOUowY2tNRUVBUm1tVkxHNjhsSkUzRXJMSzMv?=
 =?utf-8?B?WkU0MUc1dnNZd2pRV2U3UUlwSkU0M0ZSZnNhNzVFWHZ1V25rdDFZYVh3Tm9T?=
 =?utf-8?B?akpZVW5VTDU3Nlk0U0REYjA5dDQydi9UQjBDcWxHSEZpVHhIUmQrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06551FD6F448A243A423529FD76260DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: n7ej7y51qU3mASrMvgO+Py0LEjvTad9K7xS53qpzGA2Auq0X0LP5rNjc2H3f8OyuXtjSipg+GUKQBhjPx9l2oBvoOE9oA+uGuQNeXP01pOHHbfwyX1y0qtVnQzQb0/FDqPsZQJVcprVDhNeMT0yhD/nqrb0TvRdBPoS4yenVzw0fKyzY+WhpUn4BumLuRlHV4yCaBC3QpAur5kRIIGWY1JxBAqX4FE+7SDY3tYFgNE7EBiVl9aliBlJJH5eR7ULWC0sTLIAf4juMu7+Ng0lb0WlLKtGtJHn2U5N31XWXRFbDY93PcX/PDrcJCl+7rUnbzwbPvdOh2rXVR0Se8RQYEw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d035781b-ba1c-4542-b1c5-08dec167860a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 11:59:10.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fOZZ29K4e9gkswJ6LrLTxSymW0HLGNuUKlYGok25Xp32n6NNUraWCrpbZrq6XbbddLC0+YFc95hrkR7CAf1QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8941
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIEtWTSdzIGVhZ2VyX3BhZ2Vfc3BsaXQgbW9kdWxlIHBhcmFtIHRvIHRoZSBN
TVUsIGFzIGl0IGlzIHZlcnkgbXVjaCBhbg0KPiBNTVUga25vYi4NCj4gDQo+IE5vIGZ1bmN0aW9u
YWwgY2hhbmdlIGludGVuZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2VhbiBDaHJpc3RvcGhl
cnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxr
YWkuaHVhbmdAaW50ZWwuY29tPg0K
