Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337511E9B3D;
	Wed,  8 Jul 2026 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473804; cv=fail; b=JmccXAXe7uylJZQo91jpx8gncWFpNURazTDd8whBQtw/oRYqYuApuFrNkM/F4xVMldK2If2i5yIm8H2br9+mSnxtKOPu+t1dLH6gpY4CeGHZxqlqLKmFvTQMPn/EZ5oWxIeM0nsWrdhovjvP4OYRsib9oiJuJ+9wTU2l0GNMq5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473804; c=relaxed/simple;
	bh=rIZxIvDRxc4fJx8/+Omh8mza4eE0L3iJFKZKLf5yuNQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=llHCnICUr+UneM/uYBlr5+mcu6oQxZvWlZoXTONmCoH8hb3+STambvaCO4Ib3FMiscehbXIt4RaEFa/1MmYL2zEHbaUBFlAh7liboJkBhP1p97UipW4ReW9boV0ijaPKHnffH3h1LHVDPeRo8fRDLOFYuXVUxfq5HjoBak1RzHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeWAmSuA; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeWAmSuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783473802; x=1815009802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rIZxIvDRxc4fJx8/+Omh8mza4eE0L3iJFKZKLf5yuNQ=;
  b=NeWAmSuAynGyUxbhU62/qpjEwGYvqh5TL76L5MUSR+bI07ZLwmpS7CYW
   oaqNfVJpKlU1eiqA8tqOQh1HO5IokidYgA9wEzKWNUxbVNqLrrgrwVIAO
   BL+YySUbwzJQBHNXgKUbz0LonCdkaCDeqpSLgQwoEgXkzVOoCm5t8QvIo
   ISeJZiXaMdHklu4O3nzrDs095Ac6C0p36ht3dODWJUXrPA2Kjb7rJwAub
   m1l6FkmFZWNRT2IwM45fV9cMdJ3Wj0iTqHQzXVM27mAojvDp7nuvF4+KQ
   YJgch/dN0c+1eTVshsutBGMP6MLsGh5LJzNHIorT7n2aFeriAfryP2viI
   Q==;
X-CSE-ConnectionGUID: IN2vdmzWQYSGHemfj7sSDg==
X-CSE-MsgGUID: VGx5rLRuTWWpMihN3jrO6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94737166"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94737166"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 18:23:21 -0700
X-CSE-ConnectionGUID: 3CGwl0TyTnK/+qBf2IQhGg==
X-CSE-MsgGUID: nK9m4lyPQmiuhzfVIF1o1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="247766703"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 18:23:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 18:23:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 18:23:20 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 18:23:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiwmB7zKYKJr17Ac81nqTpAUEUoHFC741nVCBicWniCEMterUj7ncQmWmklXm0kshP4yZKuS+GPUYC7g4iwYiGTADqCA9yq+LQhPj1Qq2Y1SLqMX4Q4DvKRtb4ehqO36sN5sTfG01iiju1Q/mM5hhEqvqWO1/kP/hU9gf1mltomFgyUweICIYBQPJCZR/1O4WzouN09Y+7bo/l8oS2KK9U0vg70amyE3mCELiLfYHJZjCHGcO2DTsbwgpT3EwCjEWV7KCxtcscYGeyDYOtmyr+FVyNshVMk3AnI8a42LQaf7qHANwOEoZ/KPAJUOkcTkieymNFUcbhjwzD0EK+mIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIZxIvDRxc4fJx8/+Omh8mza4eE0L3iJFKZKLf5yuNQ=;
 b=iTzrR2vYjMu7IWIU1g+u5j5pzm9oBYi/Fazd/GnvBzLfH+ee8VJZkarTSmGbbqALIngJQis2XtOBGBqcU8Hu6kMOv/bo6mmW2DfjSvIVV9na6/qqk/5ejhAULjZgZoK4pq24pg0ieKf5UlJNZScfRS/xxXGIJZ7LF+Iqri4RVjpaNwYJOwRuP7P/a+B5Uimw7nZXcMaCFq6zSKWcobMJ6q4iKj8OwN7xXgVRRDmJB1/+wqin9alKc7kYbHYGkxDXNQcw4+qUHyLGHcqPcdb6eD4XsGJYLug9mITn6vHNolszMgDnMosubc0w7RVJudn0DeOkpF6ltjXJkoINsQO38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by PH7PR11MB6553.namprd11.prod.outlook.com (2603:10b6:510:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 01:23:16 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:23:15 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "tglx@kernel.org" <tglx@kernel.org>, "Mehta,
 Sohil" <sohil.mehta@intel.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
CC: "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Thread-Topic: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Thread-Index: AQHc7LhTzhja0MT5tEOwuy4+BJvRdrZi9WqAgAAh1gA=
Date: Wed, 8 Jul 2026 01:23:15 +0000
Message-ID: <fcd76e805ff1822dc9b3e3aca6e948c58e6b6a33.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-2-rick.p.edgecombe@intel.com>
	 <a4b596d1-c0c7-4674-b5c4-dd565a6fd3ec@intel.com>
In-Reply-To: <a4b596d1-c0c7-4674-b5c4-dd565a6fd3ec@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|PH7PR11MB6553:EE_
x-ms-office365-filtering-correlation-id: bdc3814d-3349-4809-30f2-08dedc8f7c62
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|921020|56012099006|11063799006|6133799003|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: fsRdKFFBx+NrBj/1FbuWnvNATpkjzMgJEU14eXTr6a4XjzyamjobfuseeMclohywUT3o49dgnc9rF/8PqzukCSoHv++3EaQ8GRrhuJXt9rRSI0ivfy9Dk8htU+muQ+2ljj69ImoaqLvJNQKSLyYCcMBgVyZBdqFPbdJNTODdyHY7TJXMykZ3nHdPXXSG7tbOL8oSZPX+dkTOBJs2GZYgthU/DE7GA0TR9j9X5AUY/1+KIrzS8kAnlFo6fhU7HD+VZ9VD0VLqXBBdNIOKIGwm0nviiTFLb62t61Vu9ZwyosMhvstZbgNNmUXLFueScMIDecuiCXBg8isSacEfaTGc7eyjdMfY6oo2aWvIEFs7DRMWaM5679hPDKGADS4UTQnkTnVwU0WD/kabjY+A9qgEAg6vUX8BGOAdEhI/M/1QiqHpcyXLU68epdy9B4KWRbRWaM93+hfxA6XwjEjBVi87ehmsKtJV1EvTgiNKmmkYXM57pTXAdpyDh3YkcVN3geeNV6LAYOyBpbmFcfQN/SyiDr0eajwPxJG7hb1U5Z6whbSDngINR2cts8cv+H/PekZD3nFONQpkRjmg04QeTrbe32W/8Fury0snX7koy9XXQTVGElp0EL3kGCfVWsJVD/MTvREQXP6IxHCPAPGG1HrwaEkdT88eg/IKOQ6YtpToN0zIxOHcW7zYEytM2mtmmMRyIDMtQTem2aiNAYckJdUn0Y7focWpplRgVnc13dhu2ah+dhoFyQBPJLfcj+8VmP6v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(921020)(56012099006)(11063799006)(6133799003)(4143699003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXJ1TGdyT3VxSFBka1pQVkZEVWYwSk9ZcFdZRVFrRlBqcHE5cGpaSndwSXVM?=
 =?utf-8?B?Ymp2YlRhYlU3M1NGK1IzZjFsdnJ2MEFBVjZoKzh3cGwrTENzcktOOUlwSS9w?=
 =?utf-8?B?ZXcrMGs2NzlyUDZRQWRiK0VmLzM0TzhGKy91eVFOUlZsam8xamVaUFJUemVT?=
 =?utf-8?B?eWZDMnhhV3NPdWVkOHQ3VG1oUXBIMHFQRXIrNnJPNTlxMW80UHNtd2pwWXJm?=
 =?utf-8?B?NVJkT0puTWZEMytpT1dTTkNwcDN2YzFQZXVXeHR3V1h6a1Z4eUd5U0t0WEV4?=
 =?utf-8?B?SlN5a0JEVmEyZXQ4K3FVb2tCckxYWFhHcXQ3Tkx0V24wSEhRcHNRN1N5dE4z?=
 =?utf-8?B?S25nb3Q0KytYdlZwTXFJMTZBMnJDRlJudW9jU24yczA4dmZCRVhmL3NNVkxi?=
 =?utf-8?B?c25GUzJoVzFJRkthb05FL0pHSGh4YUR4anNNMmNFRHZNOXFmZVF3NzYvMDR4?=
 =?utf-8?B?N2phZE8yTXRrUytwRlhZRU9SQytTTUthMExIZzVQc2ZqRjRRa1VBcDd4RWlz?=
 =?utf-8?B?WURObjYzdWpFNGVnYklaQVM3T2d2Vms2aDdDWXE3WGdFV3hIVFJ6WWVrdHhx?=
 =?utf-8?B?Q0x1a3Z2Zm9DNDVpY1BkMnJQeHMvSkFMRi9JNjdQczI5RU9RbmhPbzVuUWNP?=
 =?utf-8?B?U1BWOU5BbmNsZzlqS1VrQlpFR04rNFM3TnFkdng0aStLSTh4Vkc5d0JGckZx?=
 =?utf-8?B?UGdHNnVLR3hPWlN0UEZ2OXUzaDdETWVzaGxuNUlXUWhuQTNWS2dmSTkvU2la?=
 =?utf-8?B?ZzljbmFiVlhCVUh1NlJ0Q1VRZFdsN1VkN01LM0lZYm5Fdy9oSFlTZEpwczlR?=
 =?utf-8?B?S250c0VxN3JaTnhpSUNkMlB0TDAvV1FHQW1NaUJnS1ZrR2JudXBXZEN4UDJi?=
 =?utf-8?B?VGhjd2xjMHJyS01iVEVFRnRtdjJwN3dzYkV6OE9EenBjeGhMTW82MUVJYTN1?=
 =?utf-8?B?RlltSlRaUm5IWm5YajRaWmNCd2dSd1phN0kxR0E1T3paY28zTDVNT2M5UWlS?=
 =?utf-8?B?dHhnSG5mczNDWlVqM0hyUnd2N1I4aHJCNG9reTVpTEpsem81Q0lFeHB5TW5Z?=
 =?utf-8?B?bFh4dksrY0xFOTZleVNBNVUzaHdjYmxxSlp0NWpPUFUyNWxhQUpyeVkwQnpq?=
 =?utf-8?B?SFVXU0Y0L1VxK3drbS9ERi9LcFA3enJUV1Z5a1NHb0tXZFRYOU9oRWhzOUx0?=
 =?utf-8?B?aHY0L3BhOTQ1eklkbTRrblM2SENqUEpDMkM1aklqU3ZVS1FtWHVMN1lCWkUx?=
 =?utf-8?B?NTgwZmh1SHM5N2IwZWZJbEc5M0RPazVFbktvKzhLOVBCUmpHNmc0WjlvV0Nh?=
 =?utf-8?B?eGgraHdLZWQrWFh6cE1mYUN5ZTZMYVhVMS82S0dIeUphcFRoSEk0L0dOU1Uz?=
 =?utf-8?B?L2xVU2hHb25qRmFROHhkSlRYSnpIaWxrZUxQR2pJV0o3dlJ2NFFYN0cyQnp1?=
 =?utf-8?B?NnFRSFlzWnFOOGhKVERsWnVTSEt4NzFjTmo4QXZoTnJwWmxHSDVkdzJGNklB?=
 =?utf-8?B?dng3QlFRNzVUbDJ0ckdUb3RQVXZSOStMQmlkd05uSmhJMi9Wd1lIbzFRdVZQ?=
 =?utf-8?B?ZTF1SUd3NDl3OFd5dS9xZ0NjaHR6L3k0SkE0c2hUM1d2aVhrUTVDanJmalYx?=
 =?utf-8?B?UGI4ZFFIZ0JSU2NFTWZQc2FqWWNDU21FTTNQa0p0dE53U1NHQ0VCYlNjZVpw?=
 =?utf-8?B?RzRBdVphSTZNVTIwQUJLdU96blpWRmEwMldVWDFmZGE2WkZKcS9WUTdoeVZm?=
 =?utf-8?B?cGtBWXhJOTV4NGRDelB1REFZUUxtSjkrc1Q1a2FHSUthUkhVbHlGK0phYXVu?=
 =?utf-8?B?WFllcHFMRVVhUDdsd0ZDYWM5UjBKdldOUlREUUZzNmNmZDVpMlhWN2V4M3A5?=
 =?utf-8?B?RWtjSForc0NLOGM5ZlQzWG96TTA3OHIyekZJbUZOckFsdFZzUlhWaWhCUDRm?=
 =?utf-8?B?MFFMbzJwZXdFQ2hkZnpObm53SUFOcWlSWjhKNUNUckFPT0h1SFNQWUFnSlJk?=
 =?utf-8?B?RlZRSktQcExCTE1Gc05QRGc2L0gyaHNVZXpzZU1oM0t4YktMM1FWd3AvK2x5?=
 =?utf-8?B?dy9tVHRGcEJ0STg4MjZyNm82M2tCN0NvRmJRMkFNK1dYSmVNWXRhNXkxVWM2?=
 =?utf-8?B?ZHA1YnBVZFhkR2VjUTFEMDMwemlwK2lBSEdTOEpIeWNmQjZNZlF5eW8rRnBC?=
 =?utf-8?B?em51K0VZaTNaTzhpOUxNbHFDeGRkczdEU2tMOFV3SWlVRStVYjhUbWVDNzc1?=
 =?utf-8?B?TitJdEU0QWNFM1hBMEMzYWNYVjVRTmpETm5BUzhQYUdzbXJnbi9QejBVdjRV?=
 =?utf-8?B?NXVSS3ZkOTA0NFdqcFNac2JFblg0LzdmSzlCVjJBOFJWUXJqb3U4ZzR1RDhx?=
 =?utf-8?Q?wLzE2uJni3uQPs6s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2744F56C92F4DC43BF537A82EB5A221C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Sv5X/IU6abVUx4sUcDKjVTfTWwQZT5voIqY1TcmB4e7a+T+M5B2P4PvBoYZdrl02DxsrX4xB2ooF/sQQdZqZpC9NWXEwdDGnKJlqZ7mRw7j4kq8PXVKCxx6kUCTC+/lzGdQU3PJP8VI5vU3k9B2HAIhnYEuoUCXEu/wdYWJ13g4BcfLIo0SCwxmJhzUV538s2GAZbOEeq/NroV5GiUQHhBO3Vx9GuMiWN2cHIDAWyjoDqUyq5r99b8uZrnitmz+9vioBS1f5jJPS/HHdUYqv4N6IF8e+FbvRd6js3yt8/4+BX9XuVwTxUC8/6MiBVTQcjKJz8ceB+FJw8WqF6kl/9A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc3814d-3349-4809-30f2-08dedc8f7c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 01:23:15.8091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lPbJhg4/oEXFXpe+gP7ujpv8sbLbQU0bf2NimijkQASLGOoGlampSkSCO6LdOOG5pcl29fqRR2jtGc+N7hOadh6CV5WPe8yJa+CP4+gZzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6553
X-OriginatorOrg: intel.com

VGhhbmtzIGZvciB0aGUgcmV2aWV3IQ0KDQpPbiBUdWUsIDIwMjYtMDctMDcgYXQgMTY6MjIgLTA3
MDAsIFNvaGlsIE1laHRhIHdyb3RlOg0KPiBPbiA1LzI1LzIwMjYgNzozNSBQTSwgUmljayBFZGdl
Y29tYmUgd3JvdGU6DQo+ID4gRm9yIGVhY2ggbWVtb3J5IHJlZ2lvbiB0aGF0IHRoZSBURFggbW9k
dWxlIG1pZ2h0IHVzZSAoY2FsbGVkIFRETVIpLCB0aHJlZQ0KPiA+IHNlcGFyYXRlIHRyYWRpdGlv
bmFsIFBBTVQgYWxsb2NhdGlvbnMgYXJlIG5lZWRlZC4gDQo+IA0KPiA+IE9uZSBmb3IgZWFjaCBz
dXBwb3J0ZWQgcGFnZSBzaXplICgxR0IsIDJNQiwgNEtCKS4NCj4gTWlzc2luZyB2ZXJiIGluIHRo
aXMgc2VudGVuY2UuIE1heWJlIHVzZSBhICctJyB0byBtZXJnZSBpdCB3aXRoIHRoZQ0KPiBwcmV2
aW91cyBzZW50ZW5jZS4NCg0KSG1tLCB5ZWEgSSdsbCB1cGRhdGUgaXQgdG86DQoNClRoZXJlIGlz
IG9uZSBmb3IgZWFjaCBzdXBwb3J0ZWQgcGFnZSBzaXplICgxR0IsIDJNQiwgNEtCKS4NCg0KPiAN
Cj4gDQo+ID4gVGhlcmUgYXJlIHNvbWUgY29tbW9uYWxpdGllcyBpbiB0aGUgbWF0aCBuZWVkZWQg
dG8gY2FsY3VsYXRlIHRoZSBiYXNlIGFuZA0KPiA+IHNpemUgZm9yIGVhY2ggc21hbGxlciBhbGxv
Y2F0aW9uLCBhbmQgc28gYW4gZWZmb3J0IHdhcyBtYWRlIHRvIHNoYXJlIGxvZ2ljDQo+ID4gYWNy
b3NzIHRoZSB0aHJlZS4gVW5mb3J0dW5hdGVseSBkb2luZyB0aGlzIHR1cm5lZCBvdXQgdW5uYXR1
cmFsbHkgdG9ydHVyZWQsDQo+ID4gd2l0aCBhIGxvb3AgaXRlcmF0aW5nIG92ZXIgdGhlIHRocmVl
IHBhZ2Ugc2l6ZXMsIG9ubHkgdG8gY2FsbCBpbnRvIGENCj4gPiBmdW5jdGlvbiB3aXRoIGNhc2Vz
IHN0YXRlbWVudCBmb3IgZWFjaCBwYWdlIHNpemUuIA0KPiANCj4gRGlkIHlvdSBtZWFuICIuLndp
dGggYSBjYXNlIHN0YXRlbWVudCBmb3IgZWFjaC4uIj8NCg0KeWVwLg0KDQo+IA0KPiANCj4gDQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L3ZpcnQvdm14L3RkeC90ZHguYyBiL2FyY2gveDg2L3Zp
cnQvdm14L3RkeC90ZHguYw0KPiA+IGluZGV4IDk2NzQ4MmFlM2M4MDEuLjQ4N2YzODlmNTJmNGIg
MTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ID4gKysrIGIv
YXJjaC94ODYvdmlydC92bXgvdGR4L3RkeC5jDQo+ID4gQEAgLTUxNiwzMSArNTE2LDIxIEBAIHN0
YXRpYyBfX2luaXQgaW50IGZpbGxfb3V0X3RkbXJzKHN0cnVjdCBsaXN0X2hlYWQgKnRtYl9saXN0
LA0KPiA+IMKgwqAgKiBDYWxjdWxhdGUgUEFNVCBzaXplIGdpdmVuIGEgVERNUiBhbmQgYSBwYWdl
IHNpemUuwqAgVGhlIHJldHVybmVkDQo+ID4gwqDCoCAqIFBBTVQgc2l6ZSBpcyBhbHdheXMgYWxp
Z25lZCB1cCB0byA0SyBwYWdlIGJvdW5kYXJ5Lg0KPiA+IMKgwqAgKi8NCj4gPiAtc3RhdGljIF9f
aW5pdCB1bnNpZ25lZCBsb25nIHRkbXJfZ2V0X3BhbXRfc3ooc3RydWN0IHRkbXJfaW5mbyAqdGRt
ciwgaW50IHBnc3osDQo+ID4gLQkJCQkJwqDCoMKgwqAgdTE2IHBhbXRfZW50cnlfc2l6ZSkNCj4g
PiArc3RhdGljIF9faW5pdCB1bnNpZ25lZCBsb25nIHRkbXJfZ2V0X3BhbXRfc3ooc3RydWN0IHRk
bXJfaW5mbyAqdGRtciwgaW50IHBnc3opDQo+ID4gwqAgew0KPiA+IMKgwqAJdW5zaWduZWQgbG9u
ZyBwYW10X3N6LCBucl9wYW10X2VudHJpZXM7DQo+ID4gKwljb25zdCBpbnQgdGR4X3BnX3NpemVf
c2hpZnRbXSA9IHsgUEFHRV9TSElGVCwgUE1EX1NISUZULCBQVURfU0hJRlQgfTsNCj4gDQo+IEJv
dGggb2YgdGhlc2UgY29uc3RzIGdvIGhhbmQtaW4taGFuZCwgcmlnaHQ/IEkgd291bGQgd3JpdGUg
aXQgYXMNCj4gdGR4X3BnX3NpemVfc2hpZnRbVERYX1BTX05SXSB0byBtYWtlIHRoZSBjb25uZWN0
aW9uIG9idmlvdXMuDQoNClllYSB0aGF0IHNlZW1zIHJlYXNvbmFibGUuDQoNCj4gDQo+IEp1c3Qg
Y3VyaW91cywgd2h5IGlzIFREWF9QU19OUiBkZWZpbmVkIGFzIChURFhfUFNfMUcgKyAxKT8gSSBk
b24ndCB0aGluaw0KPiB3ZSBhcmUgcGxhbm5pbmcgdG8gYWRkIFREWF9QU18yNTZHIGFueXRpbWUg
c29vbi4gQnV0LCBzaG91bGQNCj4gVERYX1BTXzRLLi5URFhfUFNfTlIgYmUgYW4gZW51bT8NCg0K
WWVhIHByb2JhYmx5LiBUaGUgcG9pbnQgb2YgdGhpcyBwYXRjaCBpcyB0byBpbXByb3ZlIHRoZSBj
b2RlIHN1Y2ggdGhlIGZvbGxvd2luZw0KcGF0Y2ggY2FuIG5vdCBtYWtlIGl0IHdvcnNlLiBTbyBJ
J2QgdGhpbmsgaXQncyBiZXN0IG5vdCB0byBhZGQgZXh0cmEgY2xlYW51cHMgdG8NCml0LiBJJ2xs
IGFkZCB0aGlzIHRvIHRoZSBsaXN0LiBCdXQgd2UgcHJvYmFibHkgaGF2ZSBtb3JlIHByZXNzaW5n
IGNsZWFudXBzLg0K
