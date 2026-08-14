Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDED9279DC3;
	Fri, 14 Aug 2026 00:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786668303; cv=fail; b=lS2QOocjK9HeQYCxhQkx3xKxW0RSXvh/wk5Z6WAzNHmSwEMUkk2iFGULR4jQ3thZkI1WNZLLAjqWr6tcDGh3JUcGKJO7iL5D8lzeTXAGaqschblMD2BBq2apCgdjK8zuUFPriOniJx0y8mAPdUbavSmnMT54g+irdd8s/X/adi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786668303; c=relaxed/simple;
	bh=akbQiLXZ6IlvsWgHipxwdP4dJJuTrAxt0G4UJFQ14Q0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uh1gTqfZhGe0rbgcjbzF6thhHeBCd56saX1B3wAs0IxAd+JrOWJqk95hJkk1zKXJoDcpJ+cCE52mRZy7+yJ/GFSsOqXo2x+nRqAQxqcrJAF8ukjUbVNUAHgGTllgEgGUgQZ0nTFHwoOxSR2IIGterpD0b2dS4D1M7CRDBLJznak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ny0oaMEY; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ny0oaMEY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786668302; x=1818204302;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=akbQiLXZ6IlvsWgHipxwdP4dJJuTrAxt0G4UJFQ14Q0=;
  b=ny0oaMEYDFewBU1UwxK8+o+3GdNZqbkitFzf+s7vLOffOy6nMPRLbK/i
   1Z+a+iR9o7M/pMr6CK9OHidE18mJuVm/Ev6fk3ZNkdJZszezpkeJH6p30
   kVs47d3cfQOKKucicbywL9NnyqAtxb7vkdROQ2TYwvh8W651m/ZcoYRtk
   XM3SYyIVOlAUw9o+hSEIgPP7B1O6TOnqTESnBnMEBBmfIriJWeHh3NzXR
   BvB3NlT6Mld4RK3zVgLlgyCpCerMgGVGSyv7wPQytU8i88JYTZT3gDBSu
   G229y2gAKiyu1MQB6Dg90Aolpn4qlCYKzE5wZLYMbfUIWQ+9pKoGuVHft
   A==;
X-CSE-ConnectionGUID: 8Onh7+tkQtitSXrlZmlQPw==
X-CSE-MsgGUID: CIJzfEWJRROvSltjdnL1Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="112794104"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="112794104"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 17:45:01 -0700
X-CSE-ConnectionGUID: 4Tg0NFWqR6esfL/cpPHmYQ==
X-CSE-MsgGUID: i9vcq3YATmWgouMSI1lb9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="294013768"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 17:45:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 17:45:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 17:45:00 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.53) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 17:44:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTfmh5VdFR228px0ywio1KT7SQJLJkCUhOeYbd496euSfthT8su77VoeDH735OEUGwp6zV9IRBmQkU9W+na92M7JlU/CAk6wr4z/n9nlKKskpIg83k++/oNUeqXj6o80yD4DX0ZG0WHJt0DuXNJt1JYkEHK0hg+I+yhI9uYN1kfuxEARxRgv8S3hU2c1sWrWU0GO8UDZh0Kst12j0ocyy0Qd8FYbr/OzRTGqddYr8rWznacHUvDPqpT8FvRogjPGLOoxBBazx4qS8/mkJUovICUCSddpgs4Y67EYjsj4evwsUiBxaSB3iFNt1kIRCOZWH7ahhXJ3T1yI0+v/iI/kOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akbQiLXZ6IlvsWgHipxwdP4dJJuTrAxt0G4UJFQ14Q0=;
 b=vRUrtYNmEHFXoPUZnXsuaIYJO2r8D5TPcKbbSwyGRAwj8qcs30sPcmoBkYqhBxYd9b6umQwHRRfdM7ovQ5IgC7NVMB/RR0fZl1fivhjBKlmm++rGhwBC0l0MAt4tgoMpU36nE6ciTPjm2P2avmmBT45Frd26foywutpgFLuSufoIEgPByuxZQ8t/zhyiroX4VpQP62HCSRgQU08AYTRU2X8l9AsMo+q+oIVvRinAYVtqBFUb331J711WqQsRMH82nteU8sy0QMo7E2GyiXkwqhSOpCc1p69waQz1rbC6wMsabC8F6pmm94kzqs7WkMLBs9PtDC8vCPrzm845pnk10Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SA3PR11MB992341.namprd11.prod.outlook.com (2603:10b6:806:58b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 00:44:54 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 00:44:54 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Aktas, Erdem" <erdemaktas@google.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"afranji@google.com" <afranji@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "seanjc@google.com"
	<seanjc@google.com>, "pratikrajesh.sampat@amd.com"
	<pratikrajesh.sampat@amd.com>, "oupton@kernel.org" <oupton@kernel.org>,
	"wyihan@google.com" <wyihan@google.com>, "sagis@google.com"
	<sagis@google.com>, "Gao, Chao" <chao.gao@intel.com>, "Wang, Roger"
	<runanwang@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jmcrey@google.com" <jmcrey@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 09/22] KVM: selftests: Expose functions to get default
 sregs values
Thread-Topic: [PATCH v14 09/22] KVM: selftests: Expose functions to get
 default sregs values
Thread-Index: AQHdGi/hxauQmPt6b0+OMtPNB7dFw7ac19uA
Date: Fri, 14 Aug 2026 00:44:53 +0000
Message-ID: <b7f7ad93360d7e0fe59ab7f3b0ed6fa79375001f.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
	 <20260722-tdx-selftests-v14-9-15ad654a50db@google.com>
In-Reply-To: <20260722-tdx-selftests-v14-9-15ad654a50db@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SA3PR11MB992341:EE_
x-ms-office365-filtering-correlation-id: 39d4ba81-32d0-498f-88ae-08def99d41a5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|10067099003|18002099003|22082099003|4143699003|11063799006|38070700021|921020;
x-microsoft-antispam-message-info: bru0hEEy0AqflQ+quPISxrLo2+tf30S8zNDW7NynbH+KwRqPUT+44CK7ZcM9fQbunPbPqPM94gberXSPrEFwPioTYgWVNINufoPBNd++EmeV0XZ1CaIJlHwb9TohS+5xqerCN29++72imHATMTEG/rqgsuHEpBU+AOSqX0pvrS3+BJcQh4Ndis7KPMpsPkv55BzVhh0T1Ab8LOtX++JOHeekzm6FUbpmYKJ1pJESRYMR68Yz1x88//7CY9O9nxPkzn2lnLAs4WNUf9u2UYF0HvrTwK31kO28q9Zkx0js10/H94hftbXE06bbvyUt1ydzUHjPhH9Hqjq0WXmehPS6veByZnQT6MfbUoLBcUDCxeUcF7yJNHWFxwwe+jeC2SjNgSqCCNCZx2M3xI5tvzHuyORfg2tipeRBaT0IH8jmv2E3V2eJ7QLQGiOGXo0R5VT9kbXEAPHEC3bvv5wH+SpnF/I0DGMMhSKaSBVOQt84GNXehmtdz9VKv7BHQ4sPr4dPxyf5W856a3K8//BLbzkJymc0ufP8a4/CGBk7uGyVfIWVy8dCvAfep3IZNEDAUVx70zMlWqw3Z1Oi7kFFQNn9RSbY78McAbtF8TVFFxseieOY65L2WsdvQcbenwX/YWSzx6/lladAf5BZQmOXmArmBPX2AP0MHhtnqKXJlxz3oF+CH/0yVzYiy1/HANcH9Uton45F0uX53b4R5VInupLCcR0PruXpYobtMc/hJGjIBh8ZNGEvcnP9S+qSwyiDujt1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHY1MlY1RDFoUTNzWStXcHErNzFGUEsxM3M4bTRVT0RqbjJMZlFnUlczUHpV?=
 =?utf-8?B?K1VDSlYzVy84NkZLTmVETFZPSmkzUHFCRzFuT1pLMXErQ2VBcW9hdmh4QU52?=
 =?utf-8?B?SVhsRjkxRVptejV0NTE1OFV5eUoyeGpqMlBxVk9NdjhBZTFMQWx2UUZ6aWw3?=
 =?utf-8?B?L09uUm9PREppdmV5N05nZFA4M3kxVG5MMTZWbGFoSHpXUXlpclZUdmdXNmo4?=
 =?utf-8?B?U3pvVHV4Um1HSTZWSzVCNE9WOFVBL2xMNmhWT2ZMSHpKaExEK0pENjljTmh4?=
 =?utf-8?B?MGV3b1VYM1gzQ0psZHIwM2o0aURXbHltek1HdmJ1dm9FUlphZ01HRXBsUEM5?=
 =?utf-8?B?b1hIVHJmZ2kwTG5NWFFFeWxMalJmMHAramVxcHB2M2FJT1VmcngzUlNsKzVM?=
 =?utf-8?B?cnVDZkdRVFNmSlJoSHQ0Q1hIMFRDOGN3UStDU0Vtd1pzRVl4QkZ4UGU5U1BS?=
 =?utf-8?B?Y3VjU1VDbWk2bnVmS2hma29QekMwZmNtSWxUTTMyMGlhK1FyamRJbFkyTDVw?=
 =?utf-8?B?elNnczBOOTRHSDVhK21NSzltTnZ3YnFUbEhwblR6RTQ0cmZYRGV0VGs2THVj?=
 =?utf-8?B?MEoxd29qWk1WNVNtYVB1UVJWd3krTVFRQjVUWUJhS2xuNWxJWm1jWTJPemhm?=
 =?utf-8?B?SFJLczU0QnJtT1g2cGJ0VWh6SFlJQzJTQkNPdThVWjZoQkIzait2REdDZEND?=
 =?utf-8?B?bDlLcXdzNjNocHJ4czdRZ1FuMUJNeDkrOEVnbnBnZU1vQ0VPakE2S3IyMGc3?=
 =?utf-8?B?M1pWbXpLQ0Npc2hPSU9TVUMwZlVER3lnYlFkQ3EyemZld2VuaVhEcU5KTXBn?=
 =?utf-8?B?TjhNNVAwYjlhUWZWWDVWN2ZSN254czVjeGJuUjV4ZUt0TnNyc1VYQXhyZTJL?=
 =?utf-8?B?SWdHUjZ0NGQwVGg1dDA4U3ppeVFiYlV3OFdpdzdtQjNqdDgrOEppNExqUWdW?=
 =?utf-8?B?UjdZSmZvbXhOTE9Sa3ZrK3AvYWdIRU51dlY5RTFrT0lRRFBVR2V6OHBTTkMr?=
 =?utf-8?B?YXFRbDg0YXFSdUpTNndEVkZqK0tTaHNqRUZWVXN6TTdXaEhqVXVCZzVHcGtS?=
 =?utf-8?B?M0pRamRHaUFwdTVYeEJTRlhtWWNrb1I5MzlTeGNMeUNCWGtBOStaRk44SDhB?=
 =?utf-8?B?a2RiOWVhN05wMUlQcExobUdVSTVYTWRyYklzV1FJcTRQcHh5WUgxVjBJV2xX?=
 =?utf-8?B?UWxBRDBJUm9reVFRVGsvNG91dG9sWWdSSElhdllrZXBvRmQ4NlRweUhzckdW?=
 =?utf-8?B?THJaQXJkU3VlZnluQjUzdzJreUMydVRwQkYwV2dQaHZRUTRhS0RIZFVMZldT?=
 =?utf-8?B?bUVBNldjOXEySDFFc0ZuSkJQZXJjTFFVU1ZSMFNGclluZXhzKzlKaXBMdURX?=
 =?utf-8?B?enMyVHlzZEFXYktSd1NmYXFSWW94Q3FaK0s1SmIrenZ5QWQxM2FBYlQrd0ZL?=
 =?utf-8?B?em8zMzc3a3hlOTYvRUs4d3dTK3lnbndtQ0U3TkQrSFFMbFA1WG15ZUU5cW1r?=
 =?utf-8?B?SUpwNjBteGlZUUphaGlCdFVSTWE3K0sxTE1SUUFYN0RRSlppZDhxakVXYUx6?=
 =?utf-8?B?bW1XaG4vN3kvY1VIMGFMUDhDOXZFdWo1Q2ptYlVKRksvQlhLU0huajhSN3R3?=
 =?utf-8?B?cjFmWStIRDM5VU5wQnNCbUpnK045VndVc3JrMXE2ZlRIZWFrTUpaY3lNRUEz?=
 =?utf-8?B?dm00MUM2aGh3Y05QeUw0Z0pOd2N5Uy8rNG92a0daTWdpOGthdUpqWnJPWmFt?=
 =?utf-8?B?Rk9scXhpOHg2QkNacWJtYnlLd1lScG9nQ3FhR3pPdlB0R0p0Ky9LQk41UWZP?=
 =?utf-8?B?UXR3N1ZsY3ZCL2hCM201R2Znb2hmUjR5RkUvbDVZNVh6MFJKU3YxWkxIZEN4?=
 =?utf-8?B?WHM3ajJmeUUzcVBPd3RWK3gvK0kwRXZyeHlya1AvU1Fwd3Vyd3E3dEh4Z2ZK?=
 =?utf-8?B?VzJjK0pwUzNzZWU2bjdmQXpONjNiR3JZRnJWaFptbG9zejlFU0pBRHpCZ2Nz?=
 =?utf-8?B?b0Q2RzRDT3AvajJudVA1SXhhQUpZbGt4cXpJbHQ2dmFRZjFyeSt3SktRNjl4?=
 =?utf-8?B?WWx5U2RjTjcrRkl0anJjc05VYWJPV1gvREFPM1REZFErZ1dNTmV1bDBxR1ZZ?=
 =?utf-8?B?TnNscHQvazhIVGZ2b0lMUjFuYVA5MGhrVUU5U05KekJVcnpXd3BQcWtuSkJh?=
 =?utf-8?B?UGY5dkZlZkxRdWRLVmJNSWEzWlFqZ0dWOG1oaExpMVZRMk42SjRBbWx0WExt?=
 =?utf-8?B?SHg4SEM0cGZORFFsRUlXRXpVWGd1cnlEWjZMUFNPMWxXMkRvcEY2VGVraGxz?=
 =?utf-8?B?WkxuQ2dzQTFpcWtOQjRvSVYxV2VqZkVPQzJpS3VWRE4vWGhFZVFvY1pBeGVv?=
 =?utf-8?Q?SB9v63sGsrjxMoqw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B091D54D0EEF79429F41A1FDC207E11A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U7l5CKWwHJ7kHQoOMm5FN44sKopGw9h4GobDQVx5HYQuILKdaEOEHz1m4yz3N1oEyxZzU0h8wmWeqrA5FY4iJ1lJCrNL5dASlSFnJ0vQj7DFr2+vunYaBHHtqtQQ6HQOzlD7b4uywckR69rV9RnfVPvoFpOdPK6OEQO6wj4GhNzMp2pV/m9cWm8gYwpxTgmWoUf6fqqddxBm9P5xy0BlURS20SFSWuwjcczTepn09hLvDMyTCavqx24uBfpq4W84Gv+Ht53SA1qFoTfxxVjiCx0z6qonU171bNcAzWIDXSoNRwDoXusq0o5se6dR97kWkPtmlbI+jOeucka7oK00ZA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d4ba81-32d0-498f-88ae-08def99d41a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 00:44:53.9581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3a4jD8RLO4eNF24LyIGnmq8TtpWN7DDiIdlYTxg+o6UnthlQHRaY0SE+k63ytL8cKGRQ3pde9KErDMXY0Nk739v8b3VM1WgWm9NU33fhSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB992341
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDIzOjEzICswMDAwLCBMaXNhIFdhbmcgd3JvdGU6DQo+IMKg
DQo+ICsjaWZuZGVmIE5VTV9JTlRFUlJVUFRTDQo+ICsjZGVmaW5lIE5VTV9JTlRFUlJVUFRTIDI1
Ng0KPiArI2VuZGlmDQo+ICsNCg0KSXMgdGhpcyBuZWNlc3NhcnkgZm9yIHRoaXMgcGF0Y2g/IEkg
c2VlIHdoeSB0byBleHRyYWN0DQprdm1fZ2V0X2RlZmF1bHRfaWR0X2xpbWl0KCkgYmVjYXVzZSBu
b3cgaXQncyB1c2VkIHR3aWNlLiBCdXQgd2h5IGV4dHJhY3QgdGhpcw0KZGVmaW5lIHRvbz8NCg==
