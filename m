Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516A21096F;
	Wed,  1 Jul 2026 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864518; cv=fail; b=J1AYCtXnhDfhn76gNfuvLg4QPYPVKe2mhJxemA/e+vrFEK7fKj5xVFjGWLheKQes75ce9TocZE7ZZTTT109d4jdMVvPEAhuBwgT3x3FO9Ze5hxx1Ul01M+a6pPKq/SwXsT6EYqMFSLiUBRPca6j6xVySzs43D+b3sVfLUa2ChOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864518; c=relaxed/simple;
	bh=F+cx67Tnu9hp8FxqvNTzZ6AGtdtwH7B9dmhsdwnEfko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cw+jbneGSuDxG4irQpDpNjgLvAYf+3JxXiMvg5phBNRmC9ezTtMMnqtZsaor+pNg8xl04JfvBTSBpEPyFz3Aq4nkYsKnHuReNk4kSXUDxd1pQpphqIpfBaduGgAONLzGUVtQ4fzNDdjajA4fiamo/aPCg4mZ6XTeUcQDi2wQxj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISOUyN6d; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISOUyN6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782864517; x=1814400517;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F+cx67Tnu9hp8FxqvNTzZ6AGtdtwH7B9dmhsdwnEfko=;
  b=ISOUyN6ddLosUj465K6At9lgn+2ACChF1MS4p27BMoLISaSFv7zelu/W
   TcgyU+FckR9ktob457sTeRaYa1acc/a0MKS1+CZB6jk2BugzEIXjOf/34
   TqLo4DPmyiw0xzqQoPtYDntpmjZwdlJCX7OEPFm5bmgvcbl/O9H32tE2J
   QQc4sLeFpdT0i/FNe4lwiPXYam2QsVGCS/cYqBqQ2SAZrwufBTrQvh45t
   Z2PzoBtQivBbyN+rptZJkU7+eStp45y1f9cV7y11WtqsyRn5HZCYRZouI
   SEwMPtlSlsWJ1ihbrvg/n/PAl1MsHKN33pcIgFXup27umkBDqtlxu1rde
   A==;
X-CSE-ConnectionGUID: P3bbjHdzTYqVMkaXQgiPlQ==
X-CSE-MsgGUID: Y5OxEzWqRGiGSKzUnxni8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="82704738"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="82704738"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 17:08:37 -0700
X-CSE-ConnectionGUID: BcyY65dsTo6RlndngsRgig==
X-CSE-MsgGUID: /GtR8iCxTsCTXByJkqqm/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="252529286"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 17:08:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:08:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 17:08:36 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.11)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 17:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXyDx8UZpF/c2Jh+Y3cfYWTHPfCM302J7/dL1SbzCYBNrtZYta+/+UqtzeRe6CoQ66UQAnIFtYy6r2T/FRaMaxQ0gKFHbLRyAFmw9KjEpEqeqDzZ043sjA1/Mp1BOXHP1L5PX+aifbX8e+qWC9cvatBkXAe87zjSBm0IeIaepyZ6MRPJBVwJdjFH8OWY+DmQBbEqYnRjFzm0YBbi6UzGjRsyBBq426l+VYPnk+v/X+agxjN7XCQgmXSJZEr/Wt3V8JQXow5x7U1BmTf8sL4lX0txr2Vr2g/jmsBqS0ZtfLe5BTFKMjTOahpAC7R6E+yUOMiE7Oqs9jBXT8s/ojbllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+cx67Tnu9hp8FxqvNTzZ6AGtdtwH7B9dmhsdwnEfko=;
 b=IoKI3HdoANl6gdxr8eW1zXH0/IjpDvNxP/TvOf0EsXL2g5snjN66BxeJctJAZ5r/GlgT8SffsMLkTM4UizsBgnlssydj6oAMuKHkpBu3E0HJ0RwH4sJUQTc86ulIv7vAefrSGabN2yIsSr2cuFEno00ijWx62S/dcMmE19rg8RT7zUzJWkCh4gw1ATN5e0VgSXnjGehdI0gKR7V3YX4YLMPv41XPylXhh6ngWJv6+FIgyATxD6Kkurqtq+mmzJjIuqEa9DUwBoeGznBvAwXhhYVsb1KPO8HP8bWMI5zeVVk9G+6IC5UdVxY7Vv8GeA2VZUjd2o+EPHhTgm8BsMkPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB6776.namprd11.prod.outlook.com (2603:10b6:806:263::21)
 by SA3PR11MB7533.namprd11.prod.outlook.com (2603:10b6:806:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 00:08:32 +0000
Received: from SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1]) by SN7PR11MB6776.namprd11.prod.outlook.com
 ([fe80::9c32:5b6b:3a48:dfa1%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 00:08:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kas@kernel.org" <kas@kernel.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Thread-Topic: [PATCH v6 01/11] x86/virt/tdx: Simplify tdmr_get_pamt_sz()
Thread-Index: AQHc7LhTzhja0MT5tEOwuy4+BJvRdrYunpIAgCljfYA=
Date: Wed, 1 Jul 2026 00:08:32 +0000
Message-ID: <f6690a95a55644f739df7162f641666d39480e07.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <20260526023515.288829-2-rick.p.edgecombe@intel.com>
	 <aiGheH8YceumotUU@thinkstation>
In-Reply-To: <aiGheH8YceumotUU@thinkstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB6776:EE_|SA3PR11MB7533:EE_
x-ms-office365-filtering-correlation-id: 4517991e-c567-430d-f28d-08ded704e34f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: VXsEiUDGHHSqsrumJEAHBojEG3AkrqjfJousuf3RHjRBMrkzw86wiqYL0ehe9cdFc7Tr92ZexatxVGaEWXui/C6boeOHVBQFTxS7BFz2YSCn5Hx85bJa19+jo3jKjqeNRHN7GoV7i/K5xBkfm2xmalEm/gdtxwflvEwqxSSNb0MzRrXisOiUFNHQcUqH+MA1QEVJh1NL8ph5V5nqiBDWZFEvjVChc48sRwNQY/FkCkCWJ4GYwmz2Aoh7euj8MUGLUmjc348whjC+zxHbXM0D90VLSBflK7RSw0P4B77X/mGFqell+zKkrgP7oo2bnNlkJPSbCSldcpdG0Y+ZIN9ZmEEtALEX4EQ9GVmapbHSWLWMZ9xuCgiIU7AHeBWwNFsO75K19F/jHW9K7tOulmJfN6eBSpt6bwrItOPkxL1zSa53mjn0saAwRL8AQQyXCt1PBi9FKXSOun2aTijootSUDTYVT68xihCYqY5fvnoI7N1qp6z+BFXhHA9gWAkkrkKPqkkKToSrdA8gs4htjiPXNMlpM411uPYVTGS+qD+8Tnnt1qpaIy5JdnWClK/PP9ACvZXrxp9jgOQGP2Yy8uZjqWKMugiJ1dss0vlp5NtbDM9+gOuybzpyNxYA1/NNVUoaSwYzmtU/XG625Pf6JS8QgKgSU6pfO5NrguibwKZL43cD+E1LUVUtXLuwPP19IRabnFabaqs4BoZiJfL1W+kZlOJCuIbg7g+KARcNbsmrDXA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB6776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REtuVVRQTWNaMEpEZWNYVXlPNEZBK1ZLMEREZm9RQjdHN2ZHTTUvRXZwb0wv?=
 =?utf-8?B?V1hHOXdncGcxamY1L0tJc3d3UTRvalNzRHlGL3AwT3BHcFpHdHFJWENwYml5?=
 =?utf-8?B?MnJpempTR0N0UEpZL3hKSkVOeExQYjA2QVAwR1RYWUNZb1dqL1NXdmxVYmQw?=
 =?utf-8?B?WDFGY09vejdlZkZMVHE3WTF3ZmFDQ2IweXlPbHV0ODNweW5aNSthT1BYb2tE?=
 =?utf-8?B?NEpXb2ZlZDMvcVpBUDhIQmxlSWJCSDNyUWFCMHNUOGVjOTM0dlBMTkpBbFRQ?=
 =?utf-8?B?QlhoRVFiVVVMUlpmNk54Uk92QW84M3h3OHEzdjJLYVk0UnFtVlREMWsrQzRN?=
 =?utf-8?B?c0tuMFZpcVc1MmRLcyt1NTBycDZhS1NWeEZxVFdVUlBldDVFYXZoWTZpR3JD?=
 =?utf-8?B?bVZYcTJIdmtlRXRkbXU5ZDI1SC91Vm40MVB2aC92VjhRSkc5ME5NUStveTIz?=
 =?utf-8?B?cndQdTdUNWt5VjdIRmFWVVFRMFY1WVJBa1MzdTRRWTZVcU9ZL1JEY3Zqczgr?=
 =?utf-8?B?bzdVSTZmV3hIOHJsZXI1RUwvOG96N3NiaHNnakZGWldtdVNDVnRWc2tnblUr?=
 =?utf-8?B?ZUlRTkRWU3Q5VSs5N1pGSkdJQzEwcHN6Y0drT0Q5emdKbGIwcDNFOVR3MWwx?=
 =?utf-8?B?UVNQaDhXOHl2L0ovbTAxZHlDRThKZGJPQldkVDFWS0p1SWhpbkdUUWt0Q0ov?=
 =?utf-8?B?Z05DcUg5bVlraUR1bVlNbmJSeUNvbjlJSUp0QXJJM1BBVC9RRTJPcUJTV0hs?=
 =?utf-8?B?VzE2VGpTdkx2RmtvbVAvbkRBM01SbXVXNnBpMTN6NkhOb1ZWNXgwU1E5Tm15?=
 =?utf-8?B?RHpNdTNCTloyeHd1VWttQmxHeTRZQWl3RE1mNUYwaXhWd0JTdTJoL2dSSjdU?=
 =?utf-8?B?bFFsTzlBWEtNajRUUlU4ZVhHM09GbStsWitMT1BrcmxRT0dCZnAwOXRCSHRU?=
 =?utf-8?B?YUVqaHo2U3M2WHFIMXg0a0wrbFlBdHZvdCszZVNhb0xydUZiNGFIejY5bm4w?=
 =?utf-8?B?SlFsb2kzTUprR0tDMjMxVmNsR01tM2pYRDFnTldlUFFvZVlhZ1dvek1MNDRT?=
 =?utf-8?B?UzI1eHRJbUVuc3ozaFpraUk5Rmh0Y3pTVFVQVjhVdmtWdXNiQ0hJNjlVNlNQ?=
 =?utf-8?B?S0NmVWhIOFJ6UzVCQVJGQ1NCUkNCZk9EbU1uVXZvb0EvUmpMeG54OTd4bnZ4?=
 =?utf-8?B?T013UEl6QlZvOUlRR1NYU1pGRjQyVHJSS0cwRWt3Ylp3K3pneFM4QjFzK1BX?=
 =?utf-8?B?bmhRL3VEeEZoc0tXSnJvbWl3MlgvTFRLUnZMME9OSFFyOU41VElHMjRhcDNn?=
 =?utf-8?B?MGdLZ2FxOHBxckhYdlBPUHRrSVB3WmFmYUxERWpDRlA2R1d2ZVFTSWk2Wm9J?=
 =?utf-8?B?bUJyYzd5YlZjS05EUERTc0RPWDVIZDhXUWRKczZkM2pCdkRKazhTNmpqNEk4?=
 =?utf-8?B?aWFsOEpNY09HTkJNaGhJN1lDRmliVHpZL0NDNzJtRGNzVlRNUzFFZFVTRnBG?=
 =?utf-8?B?ekhIcFI4TXZJVjRYcGRBSTFaRkdjemJtamJDdXI5ZEROenJFMDFMUTlIbU5a?=
 =?utf-8?B?WFlDb1M1MlZzb0UvdGFPOW5qdFFFSnVCSDhENVR6eEFPWDAvL2VrYVdMeHRj?=
 =?utf-8?B?WVJrZmRWQ25zUFdWZDJSbFZBamtBTDNrRkxIK0h2ck1SeVFTdWNlQ0g3Z2Na?=
 =?utf-8?B?UUJzNUs4RitlMkM2SFNqWjdQaWRhS2J4OE1FMTNxS2VBS09kVVYvWm93ZXNy?=
 =?utf-8?B?Nkc4Si9Sc2c3cW5MbkxDRm9WS3l3UGFtbWY3Q3pKRTA0MU1veGVIK2lnT0l5?=
 =?utf-8?B?SjZKUDNqUlcyRFh0SWpUM0EwSkpDaGxLbTJQUlFXR1lVandndFNydmtGTjA4?=
 =?utf-8?B?cnZNbUxES3RNVlF3M1lyVzRNN05pMWwvbEN0VnpoOGxiQzFVUmRTL3pDUjEz?=
 =?utf-8?B?QWhYeXRTL2g1WnVFVVcyalJZdllaV2ZCYTlROHkxRTdCcnR0azAvTXluRUtO?=
 =?utf-8?B?cExRbHhSK3NsWU9yM0doSFNRNnVLMVVjeUVLRy9YdlMxNWdjTWNuRTR5cm9P?=
 =?utf-8?B?TklkTGZvUUhpT296R0QyTEtKMU5UdjRFUWpaQUZjOEN0THo0U2dvQ2h2UXdM?=
 =?utf-8?B?dG0ra0hQWWRCWWJHbE9KcGFjRUJUeDUya0gvL1RHVjFSVDBEWDRQUXduTkdP?=
 =?utf-8?B?ZGV5WEpxZDRHNjRldHA1cVdlQWJkZC8zY0I1czI3SUJrR2lYK2lWMFdFUFhV?=
 =?utf-8?B?MVZ2bjAwRWdEMFVNZzhQVHhPYTNHZUV3eUJmZlVrS1hRbktveUFRYVZpai9I?=
 =?utf-8?B?bkZCVGphWHZRWE9GV09QdDdhbEJMN2dIYm0wOGl4SU1iRmluNVRXMG5ibUpC?=
 =?utf-8?Q?4lgykoJGaXFtITho=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1FBF238FC5435B4387DE39D7C0416A51@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: O0mrr4fDCQJoCCyp45oJUYwfi1LRHaxBFCnwQ06MJ6GkabysxO2ubzHse5QSYMpTmesYaLjPNkw7hYkBHIS9nwx6r9QpGojT8EVjq6Kc9h4DXNvhA5cP9Lc+5XKyiDmTLQVThXNf0qqiDP2H7/m0/PYQ5R0VkJfIjdA1hmGklZyXxUDCikQ5PX5Vll+eue7gaXuq+xKln6xOZvf+MnZS7AheYASUAE1keRC6MfVYCMVGCP94NlE/xNe/k53iR08d2WfYKp5KqEcsCVOI/sEV0uq9hE8KVWU6NmVqsCcnSlIlnzy21dhlaQ0YSrBgVvzWxUnjv8oGr492Wqy32xX7sQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB6776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4517991e-c567-430d-f28d-08ded704e34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 00:08:32.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rq8yWchckO+nqToVkcNuX1oiGR/w4MxoARR3LdKIJ5I0RHXl6JrmhrDqYRZUnWpJ97wbbGlh+8GC7xhwIJXDCPeunpSBo3LRCfBvuupOdtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7533
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA2LTA0IGF0IDE3OjA1ICswMTAwLCBLaXJ5bCBTaHV0c2VtYXUgd3JvdGU6
DQo+IFJldmlld2VkLWJ5OiBLaXJ5bCBTaHV0c2VtYXUgKE1ldGEpIDxrYXNAa2VybmVsLm9yZz4N
Cg0KVGhhbmtzLg0KDQo+IA0KPiBDb3VwbGUgb2Ygbml0cyBiZWxvdy4NCg0KWWVwLCB0aGFua3Mu
DQo=
