Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B73EFD07;
	Wed,  8 Jul 2026 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545084; cv=fail; b=EHrx5lIif1uX0Zs1N9VSuebgfyBeFN+r0yn05fBxNS/XlvEOgTwipGmI5QPU5BdrVzkVCTX3v6vuR+dyfhL+h+ZFuL+tJ6EMt8VNwa+Qkumza+8PFDH8uOtwCu7QzFb9dedv2ets9CRRod6powfSNDsRlSlX2IZD4a+FFrtIhyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545084; c=relaxed/simple;
	bh=s8GxvVmxmCvYTGqSslZ2CBstzguqXJDC24d3hEpo+/Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kr/93eC1xWhDyks+EqEW4Xvk1iXmZOBGHk0zpEG6nYKIT438iKKKVTY4tcskV2RfEQJDNbX20ZsQXB36Ncs4t+0UrPixUrltB0ilQ1jjb5WZ0YDKL8TGSUetz06pBoZnKsD1EQaQnbFByFVpjYTCp+ip7zeVm3AOlhJwqo4naeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5Q/Mgm0; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5Q/Mgm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783545083; x=1815081083;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s8GxvVmxmCvYTGqSslZ2CBstzguqXJDC24d3hEpo+/Q=;
  b=e5Q/Mgm03oIxbjq2rJ5a+RZ83AzzVeHW1fkHva/kwpuSOZvCEw9SuMmr
   b08V4myuHEUkTtTyqTUVBQKbkFc/M/RGrUsZhVjki0jX23gPmgdKkRMWu
   +V7f8BAFwPxM+9YpTB55QstemlsKAsTylwi1mk4Hs0z50NLAct41uH0U+
   hqGG83uy7uNNSdGGKCCZNMu26/KqmPGnXOJjEM/uUfK78OmF8h7O2tZM8
   0VYULeT2WdcBSxSD6FQjbMz2RyOHVyXEB6cfVBD5x7xxKJ0yTBDKYviog
   qqMRM83G2HGzN0ZTqEYZFlpjYLsZppH7cQ0cVe8++0MzIS+J/EVL3VZ+Q
   g==;
X-CSE-ConnectionGUID: /Onls1IpR4mNYuTx0A/fMg==
X-CSE-MsgGUID: PJXqrMdsRXOs7c90pQOq9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84097964"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84097964"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 14:11:23 -0700
X-CSE-ConnectionGUID: pLSPoT4hTNubXpzYmTxZ6A==
X-CSE-MsgGUID: KXD4vUbdS9GR68EF6X4l5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258265304"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 14:11:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 14:11:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 14:11:22 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 14:11:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVwb5CvPioszwMRzmP/YqeOEHBusTK2nEV8V8FkqPvng586rD38kS+NI8WgC6zFyz2wkyXv+KLoXQcMmlrPVlWgO1RvtHLC/2muB60VZfm5rx17KsVQIg8C53GHF3Gj1um1k+I4rYV6awXFiHifVzWZFh8Jl7XGdQQkoZ7Ztjqj5K0ZG2LshhSJ5epYr+iIVXYSEUmhgrlkuP9c7hg2fwHOqa07KrIVH+V7ah1Ee4rLiSHiXDVPKSVIFS0bMXTUH6Gmr+DnnAo2Ca4vVD/92rLu8HBZhoq1qGG077s4evN4+5X2iqQqWR6QdxgaQJ9ajZcEmiKkjdj5SIsdMcUnckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7/ZLe28dUSTfoKd+JKVYC2sqcq4JZuCs25uOL+xyHw=;
 b=AepniQMb+XBYrvltKIKiKli83PfkwybAUGPfxQHFB1d+5IO2e55JESDK9VGx+nzJoyzmV0WdXXtqXIQiKaTEdbaNDm36nFwdh7Xtw/e9EvgznmgU9mG6Mu0OTD6wHsbt3cVEoCgbINczhYWVQaVy8+VX1ogwjlev6DxNcIZLB0YMdHlX9tuu4KBWkD7SItUbD7aUXZAxE0WgR00c3eBEnKph2y01rQ3lisYjAh/TQ+FqgXGCXqz7Q+b0MSlHo6X7+4AeRKJeLY37dYM4XD4pLDHcaLPxVYMlOCotJdr12V4KXxtOVKwHV/OBNxi4NXNvNhI9qs/pKuJFaz4TuxdfVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SA1PR11MB5873.namprd11.prod.outlook.com (2603:10b6:806:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 21:11:16 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::24fa:827f:6c5b:6246%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 21:11:16 +0000
Message-ID: <3af17868-6ab2-4a22-907f-e994a1b18ccd@intel.com>
Date: Wed, 8 Jul 2026 14:11:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in
 tdx_pamt_get/put()
Content-Language: en-US
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
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
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
 <20260526023515.288829-6-rick.p.edgecombe@intel.com>
 <1d60cebf-4764-4785-bf01-8ca59ab2cc7d@intel.com>
 <eab9a2e601883deaffb70cfe2fbdbbc95daacc28.camel@intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <eab9a2e601883deaffb70cfe2fbdbbc95daacc28.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0131.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::16) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SA1PR11MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b202f5c-09d0-4a8b-5dda-08dedd357297
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|921020|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: e2fv7qybUSh8o+C+/4yHF+Pz1ohBqLcjWxZio5EzqTxeYKQoUIv3ARFBVhIdssurJ2SK6AmX/bM6V7WNumsKzW6mMSiEqrf4fsNMlk9qFVmrNBK2hHiAaWJ0Iw38y859FN0kvGcJbCcI7L+vWLCSW7pbiccdqm3gn2xYS1VW8iYNNhlU8vy6B8ZwxxqkIxj6kGCwER3ibXcNTUGFSUCEO9nL+ZmpPOXanDF2sObf8tOq1nmfp+QD+dQYk4A3+qUScAuI/vRig3b5eELqUBe6VDa1kbwgSlRkgdlwYJUrMgiXd/bKMGPDEU75bPPojfZP+fq+8Mpu5QffLX8YPmY26/ARx248YFyyJN7KIwpQG9k8XvjqXYLFN018X3GfLlMA125njoMlQacFz1p9Lz1OX4GP+bJlVXaqUeAjMQIc6ksJI1gpV5h48s0c+eqNWVQEOmv7OfZbXIcru+Q1IP+rKqg/3GztyeVtl3x40Z791g/Pd6IGJqKjzS57140a14jt6HDKzHkvv9f+me6FoOfWv2fWLXXJTqq/IPMm/vSxgP4DxCchXBqqU4qPeVBdv+agwayKVDPg8jGkZiBy4khWAFENbqpRnn+aMdycz4hwnh+WznkLWmQDHPLF6SLLbqAAXd/+8KAUEqi/enAAJEWn9NG191YDUuMxQdbPv2tIiK24Qjoe0uDsvIinKBh9qqeIBHXgjjcgdqB4t5+byOr+Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2FnVjU5a1lBUkNGcDBJTUswR1dVbnYwY3JlME9SQkF2OFZIRTVQTWRmTlVv?=
 =?utf-8?B?WnJXT1VYblN6K2hPMVB4Z1VLQ1JyYWc2bys0OVp6djJUS2t2eUt1TXVnYjBx?=
 =?utf-8?B?N3VWOXRHanNjKzJvdk56NW5rUXNQRkNRUERKUFJQQ3Vxb0RZNlU2UlJHUC9M?=
 =?utf-8?B?eUFMaExtMS83ZWh2RHhoNDVyU3Fac3BGZ3dqTmptTUxoaW5NRVpRdEZsTUdn?=
 =?utf-8?B?SG9qZkNaNTJkRXQzWk1oTERpTXFuYmM2Z0tGZEgrc3d3eE44azVmUXp6eVQ5?=
 =?utf-8?B?dlN3UUJGRWh1MmpjTXdOOU9vdXhpLzF6bUV2SWMwd1l5N2tYVkdQRlMrWURF?=
 =?utf-8?B?aWpOOFV6S3BMdVdzWXc3a3VtbEZSdlpWeDBJcVB1Zy9DNzM0aTZTOXNBRGVI?=
 =?utf-8?B?TWNLS05vU2w2VVF5QlU4RVpZcDRGc2U5SDRBaUdwVmtUOWE1cGZPM3YrUm5j?=
 =?utf-8?B?RWFhMVFoSHIvcG8vL0M2SE5DU3RBRExQUnA2QUhpbkc0cmo3ZGw3MVRaVWlZ?=
 =?utf-8?B?eDFoendPTmZEWXByVCtOOVpvYTg2cUl2bDdGVncxeTg4ejJYZ29ENDZ5K1lR?=
 =?utf-8?B?WEhJcSt1QStBbm5qK2Z6U2VUTkFacWZtRVdYdVYzOGdtOGpMMkgrS2FvYTVN?=
 =?utf-8?B?aTJlMzRXOFhYNGUyOTlteVZoR0RvRXpnc0VUa0VNVDFZaGVsUDdwdVl0UitE?=
 =?utf-8?B?T293K0U1Tk51MmJheFVmd3V3ZUljWiswaUVjQ2pIVG84cDJ2UnZGN2VQd0Iw?=
 =?utf-8?B?dHgxbyswK3kvTk1RaW4ramtPUm0zYzZiaFB6MU90SVBteFhRN2RJMHpaOUk3?=
 =?utf-8?B?bjUxd1dZTmdRZ09CZ2dCSGFKdjduTGhDRmNoeVFOYkpXT3RTcksxQjh3aFZE?=
 =?utf-8?B?MWh5NDlLNzVIZXVpaStPTWY2Q00vU0JOM1pyZitkM280NSsvMFhVc3hpZ3Vo?=
 =?utf-8?B?ajVXMXNQZzY3SWUxQmdUdFE3RDduaUF4czBKNEVRR3VwaUV3bUF3SFU1Y201?=
 =?utf-8?B?bTFvMjNxUk1Sbi9ZMFBIZ29pd0xvSHYzait6K3dpYitEZHBhOXZVQzJOdEpT?=
 =?utf-8?B?RmdGSmt2ajNZZ2VCaTBmWjBjSUNTY1hmd1dHQ0ptWi9UU2o2N1FsTFhmWmtU?=
 =?utf-8?B?M3dwaWo0S1BwV0VPN2docXlEVGNDOXR2VXhpRTZnalZZK0lQMm5NcGJOcnlk?=
 =?utf-8?B?UWpiMWU4M1ZXb2pBTU9SVkx3OGExb2RnZnpjNGZnLzZ5ZGRMZXB2cnhGU0ov?=
 =?utf-8?B?R1d6c01ZMWF6aENaczdRU0JkYVJOa0lDZlBnY2QyYU96RTI2NHFwSVhCKzdk?=
 =?utf-8?B?aW9TL3p0WjRkNjdyQk5HQ2pyYXplL1hBb2tJVmlESnV6aUY1cU85VGZ5Tkht?=
 =?utf-8?B?dXR3WlEzNjkvUzVLWGV2Qlh2NFd4dnR6SWFGV0FBdXhrWU12RzJPVEx0aG81?=
 =?utf-8?B?WUtUS09RTCs3K0plTnBFcGw3Q0E0K0RuUHAwZXZMTldNOWFXWWpaclVaQkVB?=
 =?utf-8?B?VG5mTWRnMGVaZWhzRDk1VTdnSFZzOGU3OFpJdXgrYTZsYXFJUGR2ZWRFMS9n?=
 =?utf-8?B?Tk1zZE03dFJReVdGOU41WkJIVkowVFhBUjdRMWdnOG5aM3pydEd3KzY5bXo2?=
 =?utf-8?B?MllvMENUcFhDUzlMQ1gzeTFBR2pJTFUxZGZSZ2tRQXhsb0dndGhqTys0TG1t?=
 =?utf-8?B?aEhNZU94bk9kMzVWcXdmekNUNEN6SytWamQ5UmdKQ0ZXenFSV29LeEVyY3pL?=
 =?utf-8?B?YnNnRlZTMlZBMmN5Z3ZMcFJWbzE2VEt2RDlKblBEaW9XcE52cjFNOUJwZisv?=
 =?utf-8?B?M3AzK0swRDBUdVlYQVpTbkR6YXQ5TU1oUzFTdVFqU3RreVU1eUFQM0xObHN4?=
 =?utf-8?B?RFBlTEk4Z3hyRkZMRE1RSjExYSs2VlFzY0JaaFI4SFZESDZtMHlFVFltU1E1?=
 =?utf-8?B?RWpGUFhwZWFudW13Y050WGhqQjVNRXF1MUxKaExpSmtCek1WR0s1Q2Y3YVhP?=
 =?utf-8?B?ekRjUnYyZDNKNWNSTjhid2R6WHhFZW5ZZ0J4MFpHQUE0cGlkaWFNNDJOSWtt?=
 =?utf-8?B?SGcxOUx5elcrcDRTQmVKTkZBTUF6am1YTG4zbDdrcEhjVXVjVTRnY1hhODZl?=
 =?utf-8?B?ZnFtaTNoU0E1SmQ1czZiZHdyU1FocHRkcStHenl2anh4enY5U2RCUllIMGNr?=
 =?utf-8?B?STJFSVhBZEpvZEIyS2pYUXdzTHVWNEtqTEVnUHh4R1d0UE5tREpqOG9vVlVT?=
 =?utf-8?B?citIRTRlQVhET1ROamtWeTU5RU01cUxpS2x5dWFVRFV5N0Z4T2RvbnFPUm03?=
 =?utf-8?B?aHUvTHVNRVFiMUhGQ2ZkWjNFMTRQS1dnZjF4UDFFRGUySFFBUlJjUT09?=
X-Exchange-RoutingPolicyChecked: bA7GYCehl8Rk8tXdgKAEQ7fzHxDJe0Sug51KqdN9xA2MjArM4IQoXJpxoh30Or9n93C12nHeFpCQAH+52GPdmoLWS4/wXLxWsJwsc3tRZoq0LlVuvR44VVsNQ15voKLXxVz2snOvIUv/Rfz4woxjTXEJQyYm7/ErCsH9Q0xChNM3GDNWFeXOg6HPhS81t5yyh+prnOJWJmO6+uTLwYsB12Mqs41KTXxWzTgingxH4igXYDaMyY6qONHHcyzEOJL8TeW8YZmkoNM+9KS99UbZSF3indzufsVyoZibdTyN3sz4oFBKHbdBMSAftHdgCYw5LlPnXmjS270XAoNxJgZ1UA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b202f5c-09d0-4a8b-5dda-08dedd357297
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:11:16.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPaD0G7ce+inpRpNoQnxFsKHitkzj5cMSi29vFp+W9SDsIdIqatMC1bnul5VXRPc0vvM3BkL06QYcmSCp2mFvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5873
X-OriginatorOrg: intel.com

>> I'd just add a changelog blurb to handwave it away for the moment:
>>
>> 	The pamt_refcount[]s are atomic_t's. They do not strictly need
>> 	to be because all access is protected by pamt_lock. The overhead
>> 	of an atomic_t in this situation is minuscule compared to the
>> 	global lock. Leave the (unnecessary) atomic_t in place to enable
>> 	future optimization with minimal churn.
>>

The atomic_t is introduced primarily by this patch (and slightly by the
previous one).

Instead of "Leave the atomic_t in place", would it be more appropriate
to say "Use an (unnecessary) atomic_t to enable future ..."?

>> Does that work for everybody?
> 

Yes, this works.

> Works for me, thanks.

