Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1E265606;
	Wed, 25 Mar 2026 04:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774413374; cv=fail; b=NEm95vxbZYQQI4NKDtWZ2iPQ9xIUq+XOyuhQSBtJ493KH+01wrTU7XOEeLbq19nAySL6S+XP6AznkikukcqCYqszeQywliJRkjGQPyxMLjgkGqeBfaLCGqzDnAv6lTQ6kArgmoDXvk9MKRb9iJ3nw4oYx4e1xhKwsGRdgtB9pjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774413374; c=relaxed/simple;
	bh=YI6V3DH0z0qbSbyvZqUmOR1Cg1q8VI3HNeClVraf7Ds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1Yq1efXphQGC6IjARksyzh50AhFwQMToI+BP0PU3pqNzV/pdNwYqrvTkp3eTrqwVs4XfsmKR5hkAXYtHTWffCBuQpEeiI3BkYd8gqdPTIzxEUXhOaAmMWY5bKFdPeVXohtkw3GJyCi4JusaAscRy4U4rADAiP8quv3dxSEEFCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUIgv4cb; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUIgv4cb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774413373; x=1805949373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YI6V3DH0z0qbSbyvZqUmOR1Cg1q8VI3HNeClVraf7Ds=;
  b=DUIgv4cbMTj9efqb/II5RAK7vO20iVhQxdmsdMVAFvmfJGDF/hGWbNqk
   r01Lc9f4Jm9tTg4WDpLHGmyrUEleCVm6mNk7zEQTqx/aJybV+PGmukkaC
   kdO4fI1CFncfTfWgHYPj0AzCUa/AnbN55Ckg8DafhgHh8Z5dfWOqc6UlH
   fok2d39M96EG4nTqqRIlyVga/1fLIFpCrUpSsrwJF0OSNknwgdN51qG/y
   MLxgJFq+bnsJBEEdOpu48hvGIjDlw7cmLf/8YfBSZ1mmy3wHM24HKIsTK
   vqyjHcET4J4PRifBTanI7+Gd9zE5Z4rjop2rEoMccxGPGnfjtrOmDHxgL
   w==;
X-CSE-ConnectionGUID: H8LE8ahHT6mFvsP+hJ2QyA==
X-CSE-MsgGUID: cNuBbmFuTrqvIUpP2XlBpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="78043213"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="78043213"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:36:12 -0700
X-CSE-ConnectionGUID: WUBIc8GkQfi6mRUnh7f58g==
X-CSE-MsgGUID: TsFEdPu7RUWALqO1OFmVaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="223625920"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:36:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:36:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 21:36:11 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkPqt8hBky5u/GHb/Q+kVPTX9oP0TLO4zCRhyVtR3j0guVBSRVmrGFl7sc+kSb29DC0hTFRCeyTvud9HXCoOr0ZCwuz5UfxaiQb9xFx/uRZ2u7KdST3+DPU+TUti0KAZqoLPANDjnZPgsgeKW0VG/L2pEkmPFa1IOejEpZ0j7o46HAaeii3871Rc5TQsQtefk0r5pT2waOOGu8y2PXCW5s4Kv9o0xDP3mr8ujZe29ML+tGdsXhtS8b66QQKb1QhVZy2pwXKPoyFY+h32UaYVKcvE4f1FK8WdT9nRWzQk0HsG0WkPs8ehUSXWzsIw2EbekqgVm8avf0cRjy8GrlBNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI6V3DH0z0qbSbyvZqUmOR1Cg1q8VI3HNeClVraf7Ds=;
 b=mTYJDLK8mIQ0MRIIL4y7Manp1vsAkJmpH+lJGvoctUvdsUhavQahWNn/1CGxaVc2+trJgJe1ecb4e3sxRkBUt/Prx2RDHaL0G8GO77nU4/Iui6gxhHdnyC9N6+j7R1Y/AIGJeYUAFTASB35UjeDKgBJvEYUZzQwvOonakhRcqXcg9ebc5xk92hOk/ajkZ6omefopNsw+eKrTXxiC/qbV/g16e7mUpcjCKXuLIww0+5qp3mtjroRvor914CLzpRLk8F8Pz6/lU2uVEB+4bZ75MvDBg7clbgSZ5O5tMgBqy64hIhWB1cfXLxDjd1/4vPhv0avK4IH//eoeNPdiYYe0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Wed, 25 Mar 2026 04:36:07 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 04:36:07 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "amit.shah@amd.com" <amit.shah@amd.com>, "Kohler, Jon" <jon@nutanix.com>,
	"seanjc@google.com" <seanjc@google.com>, "mtosatti@redhat.com"
	<mtosatti@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>
Subject: Re: [PATCH 05/22] KVM: x86/mmu: remove SPTE_EPT_*
Thread-Topic: [PATCH 05/22] KVM: x86/mmu: remove SPTE_EPT_*
Thread-Index: AQHcuMcmNiR6qmwCKkKrJ/byTJl4prW+sDqA
Date: Wed, 25 Mar 2026 04:36:07 +0000
Message-ID: <ccb7ad19d5a3264d0e13b496a7fa56799c392d73.camel@intel.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
	 <20260321000931.1947084-6-pbonzini@redhat.com>
In-Reply-To: <20260321000931.1947084-6-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB8208:EE_
x-ms-office365-filtering-correlation-id: 4c94d5c4-9031-4c38-6efd-08de8a28081a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 79zVf/J9H4vF+Ddwa42OrZBZ8SpVL9Alwm5Wr3PQwpjN0NPC5gsVCE0aUzp7xqNZxeY7EPraedRrVYqNzqrFc+or79W1iF7mf956rKSO5sTN8xLFxV1W9uTmZWqK6K07SSNBWZaj0ewspJ4IUCQDeCe5PRRAPfHkZz7ZjrlTWIBP1kyqYT4wAeQoMVJFqCDdviREkwNfc2d4nJWrXKA3oMiTrqGl2FgQibS29Olscs8wu7JW1EOU7377xj9jhEDpQ1DNI/IQi2Xbmo//G+hX05pJeQBJhneWo0FZbHdj9Loxh0idI06NLbREIVhvgwCUkJ3HWzFiLRX1mtkIzQzd7xW9yNhM4uteXP8ibePra7Lts54zEw2gXsebJC++51nhJjvS6Sz8WbHI3LA9XMhkItGiZj02jBiYapKK4n8Gor8EQtN9ZhOPcjh/KNFt6IqFphFiAjZKuDTXEK3N9i+abRaYutog7wV1py6+xXqOHjQcjYK+MWzRVDtvc0s3YyD3nHCq++rlHAEWPa+7BMkdjbk6EA400YrOaK6NLU+VLL2P65kRrvESWC8f/7xdzh5g5Wuk5mAkb3UXDWt0ZNNvZrL50kUWjgIDYQj9uQbM8jRtUKWeLHNI9QsOlH4G/x6hBNV0FOIVJ2aWzugrQS3zrkhyzF+U4e0RtJpeHXjJdy6RtuFi52QR7tmLoCMowixchytCjfyKCioS+5lyF2GVBedR9rUEE20vtP5KdNLHxBcl4eOBRz0A7+yT3dQRmmmxxxGsW/cLtuN6oCbm9iOdBxh2iaLj+jIvRDBTnt1z7Dc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGZpMC9TNVpFNmFBRFlaOWxMVUI1R3YzSk5xZDdsMmpISXpVVUNwcUxPZjN6?=
 =?utf-8?B?MW1CbitSSkhTcHlCUElGVmxSSEE5SXd0MElpaDF3YXgxNlc0TmdkajFiVUZC?=
 =?utf-8?B?YzEwOGI4MHc0emxZdnlsU1hYN05tSVdxN05OU0xORTlTWUkzdHN1djdKZG9E?=
 =?utf-8?B?Q2RJTFdjZ1NSUkJ5eWsyOWcvRnB0RHhYUFIrajVtZU40bTUzamQrQnR4RTAw?=
 =?utf-8?B?WG1ndGQyYjhJOXdpbGpSNFpXSEk4M3NRbXBXT2xiL2ppUlkvQmZ5WHp1TVcx?=
 =?utf-8?B?Z0xKYSs2cjNuQzNVWE5IRmx3NXd4dHFNcW1sNlJ5WHg1eUc5K1NXUU50SGs1?=
 =?utf-8?B?QnBaeUovVmxCQVZINi9IMDl2b2I0S0J5TkV0cHAwRzRIV1BtQmIrWXNDR09V?=
 =?utf-8?B?anJmV3NZbGZxM0dPVTdFS0Y5NG5DdTRVaE5QSVdhb0h5cDNQVGt2clY2Y0RE?=
 =?utf-8?B?RGVwR2VTd25WcVlOb1B4b2dNc3U1cG5HSjc2Wk9TQ1hFb0VjM1oxUXFmOHNI?=
 =?utf-8?B?bUZPQXFNTVcxUk9ydUFXcFl5cGtOdkdkbGVHOHVjS1dEWXZhUktEWWZjd0pP?=
 =?utf-8?B?QVdQUGs1bmwxWlloS2VyNlJjM2J0bXoxRkZMV0NldlJpajBSWnFnWTRjYUw3?=
 =?utf-8?B?eit1M29TRDFDcWlEcFg4RmQyKy9lY1JKa0hmOW5wQmorR1RDMHRsR0FqbEtX?=
 =?utf-8?B?YXJpTm82bzlkUHNuM3BrMTdqMS93L3AwSy84SXdCWVJ4dlpjd0JMcVpFeFpk?=
 =?utf-8?B?azV1UlI3L0VWdFNpMytjOGdxRVJNd09semtuMHFrZ0Fxa1BQTURmNzU1S0J3?=
 =?utf-8?B?MXRJVEpidHBDZmxFeTV0OXBySmFHbkhwQUlnQXRlMmZDeTAzK244R0hiVXV2?=
 =?utf-8?B?RjZpY2ppaVJvQStlaWFtQjc0em5XbTI5UlV2azIwQkpzM2ovZk5YcHNQNmZN?=
 =?utf-8?B?VGNPZTF1eVB2Z0t6RkhtVHA4Si9ia0w3WkRSbHUvcGVZNUJOODl6dzVCZHFE?=
 =?utf-8?B?QU1sK1d3aDhNdHNITmQrYmdPeWZHcDVyaFNkQ2lEaktpWUJNbnNSRmhaWFRS?=
 =?utf-8?B?amRlSGZRc2VCSVA4L2I4VE9hb1BKQ2UxRmlKS2VkczNkQWFXSzhBOExrc2x1?=
 =?utf-8?B?YUFDWlFIWmxjdHVVN1kxRTczazJEcGlueWNGek03UVJWQUxXSDBsRE5XVzNN?=
 =?utf-8?B?ME82STVPSExuQm8wLzh6QW5meWUyc1lCUnZYZEQ5MGVkT2RIbmRVSTZybWF0?=
 =?utf-8?B?Mncwb2ltRjVzZ3JXU09KMnQzR2VNSHRLWVRJTjhsVEJoTnk2YW5pcHhtN0ZM?=
 =?utf-8?B?M3llZDNYN0JLSDdPYWtMSU5vQm5RekFBdEs0d3A3TUJMMVRROVZrQm5RVnMy?=
 =?utf-8?B?c3hnV01RVGxoRGdCeWlTeWtJWnQvdDVlSHZrK3BPQ1BENEtwbzZibWYwTEEv?=
 =?utf-8?B?VHkrTFJRY1BSZjEwQk8wNS9qblg3Q0pudVUrWUJpeldWL0pJc2J2TUtJMFpU?=
 =?utf-8?B?RnlNOFdidlEzOWUxRHBBNGp3YUp4YkhiOGIyQStwR1RRVElKSnZIZlJXZVBo?=
 =?utf-8?B?Q0dHUUhjVkMxcm16d25GT1g3Z2lyQWZBb0RqcDhaeDM2VXp0UC9VdU5wQUdH?=
 =?utf-8?B?c1U4RzA2T005L25aVkU1d0ZkMHQrWDF2WjVETGR6aXlaaFBER2V2VHRIQVB0?=
 =?utf-8?B?QWRYNGVPczB6dGlqNDh5OUhsTDA4dW4yUDRkRGx6RFFqOWlpTGVMRFNXcklZ?=
 =?utf-8?B?cUZETHM5SEV1VWpna3BlZFRXbHl1Y3RNNkd0V2lHeUh1WmhlSE90M1l0U2dC?=
 =?utf-8?B?b052RHpDSzU4NnlpbGdNUUdmN0krcCtVcGp3OXlscFUyUm4yTGN1T2VQVEpG?=
 =?utf-8?B?TUpyeG5uSFYvcG1rUCttRGdRc29KWWVOVUtkakowZnhRWC9uYlM0cWN3cU1B?=
 =?utf-8?B?OVYvMkZPSlVEMjVrVjlPZW5WaDFtZWU2OEU4NmpsRXJqc1VoWDN1ODFCY1ZV?=
 =?utf-8?B?UURoZDBjTkltN0hNbnFON3ZGWkpWMDA3LzBCQzZXU2tXV05NT2FERUZaekhW?=
 =?utf-8?B?aGVLcGR3eVliTVRlZTFwYWtPQllNRjNYMHhUYVYwck8vQjBEOGJKdnFrRnV5?=
 =?utf-8?B?VXZ2M0lBVkdRd0ZCZDRseE1zK3FpNlIyWUx4bWFnT1JhUGRiYnlFem9ySEVh?=
 =?utf-8?B?RWNiTGIyUnZTUVN6U2VGWUhZWmlqQUxFTTBjSEtXRVZlUTdlc3M2RGR0aCtq?=
 =?utf-8?B?bkoybllKUzVCS082WGdWckJLM2F2MnRLYnRHUXhIUTZDbGQyc2xWcXlNNU1v?=
 =?utf-8?B?azhJTXVaYUlEZjVuTkZoS21KdDhoK2xuV2JTYWRWQ2sxbmlIYytsUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65D3C6B537C5FA44889E4F1D761F30A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z9Ai4SlD7VXEMNuGT4zA7T5gCgUinxmvzIZPdrQwwPp53hAqGLxuIt0rOEi2SATTh+8Jev1MwPwA0SmZqtbBQZUQ2PlYkyO1VOH54QA/uMM9gwJ3iFWiyMuidJT6NeHUUMsqHoapZdhowQaJXKKaTyhFIDdHXAh/iKvVraf1xC/xHITplnRYGzGqSNbjl8XrAAwF7TU36lsRSOmFIM3pyXdnNzOaCWwnNrjC4gCnK5pbfnHc1++eWM5CFqAgiJlQ3c5Ql3aIiYOqLmPmcXaWl4zaELYaasss3nABeLP37G+HzquPorUGMlB9B/g0xDaSRaJUNP6EiKB7KPNv2AL/0A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c94d5c4-9031-4c38-6efd-08de8a28081a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 04:36:07.2103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hd+Sgx/ceMIJkgZXe7t7x/xBPohuWlqjnNeCon5gQhiYNEPhjzEKLXv+WFL3/WI7tFhGZG62j8PKFsEwyriEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8208
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTIxIGF0IDAxOjA5ICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBzcHRlLmggaXMgYWxyZWFkeSBpbmNsdWRpbmcgdm14LmgsIHVzZSB0aGUgY29uc3RhbnRzIGl0
IGRlZmluZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUBy
ZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29t
Pg0K
