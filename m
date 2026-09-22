Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5433E316B
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 03:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790049433; cv=fail; b=VFYa0aK3ZIB0pjvA051nzOydsDiwddTxt2H7RO/ApQO+9aLzoaemyW4otLxuUI1nhn16A6cc9TWhLPnK3DKEdTJaZCBQ6lyJ/AuBjWEOelPYLufZ9tj/CBRYX6Krz+BlRjize3U2JtqQJ7ZyhOSWXmCiDlUdiJs7ptJoYHQvHyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790049433; c=relaxed/simple;
	bh=r9+CBlAaKarCmugCDfnffKlUO3OwTUctepH93sk4WYw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SzJU7xbRiA80m62yOo8SMhYlCytxmozNDNFSjKDHbGqNDi/1QwRb2B2BhXwgg29eYVqF9H4zXiKYMtifl6aNSLQSSk4HbmpwM76uV0r/j/yYRSGT1nDzgx6BCPHkFHaaM1b85HPdOs6E2xZW9eTtcLqkSRTz+IdO5GKNDVEP4Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bueWAzV1; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bueWAzV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790049432; x=1821585432;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r9+CBlAaKarCmugCDfnffKlUO3OwTUctepH93sk4WYw=;
  b=bueWAzV1z0KEgl1Vt/BFFbuCTDDpX+qRWRlRjn1wFYNpedMfvUf46/+4
   DKVE8E/IUBFxz8yngAmOAC86cO61zrwGxnj2c0mH50RsE8mQsYyJBziaN
   RwJGeA8y2wPLeJqiM8e/EiZSq+fDPvnGhgl6+jprw1NupYnBwMJsK3G2S
   0e6ESW+vJU0gpWij9rJtPVpU00ERIYPnzbrrNuARh1iMIqg3YfdbNR+P6
   J4WygT5OerAXaa4/Q65O6sH2bervEmhwz5Sj1kN34kayLJysdUWWeO2nY
   EASpzhd2daPSIkdKCru2KeTcRW/zd3PMGh9+9N+KvsPNTlczkv1kY6x5h
   A==;
X-CSE-ConnectionGUID: Zasz1ufjSNyeQg10YIWbjw==
X-CSE-MsgGUID: 8UE7MyiZQtyi9S6JYTMpmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="94447861"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="94447861"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 20:56:56 -0700
X-CSE-ConnectionGUID: YLsaFOGcQaeroGdIDlL06w==
X-CSE-MsgGUID: 233eBt1CQ9SgEAbssb9nBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="271484635"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 20:56:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 20:56:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 20:56:54 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.59) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 20:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukocnrThWRuS6oZCIg6V9JHmzq6IDKywuQnQv/UC4YDe6ayFc6Dn7j3NKb/ulEh/JjtjndbIIA0m5DD4w4wAlRul+aW30/HRDm4T3dqOLxkQ0oCdwH88okVOB+QewzMJ23vmJDdhmuoArheSu56vWh+oN3O/ZNs1FUaRjWXK5GuH/7IKdSwc5nKXjh1GreTTl/7H0NoBHXAHpniQmwWmUfz1B62oIEGb/KxMVlZQm4lsGT3E7AO8nXmVN9lWqqEhPux6sl34dWu2FH71zdx/Yaet6M/Rdb8SON8MGGyIl7Np6gV8zw579QM08FYfEyzqWak7mZp6V4OlEb1DwYVu3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1iNnW39ON2DragoaYIydT+8cYmPqAHn5aw8CNq/Rkc=;
 b=q2wHPk9Plu/1ki6L+jT1ACIIwQAbMl1pxw2G29E0fQazIMhUPAoh3tWwigzHD8Kndr0+aZorwD04MHVvaU2f1uZWRGLoMGNXmgXcfzh+vJo+/PCaMdlVyhidrgYFORKsw53CW8aTdgbi6HupYCRtbT2U7CjtFn1YdssXppqQVww6ylRyInT4JgyCaXPNXRPZePwJpLICug2+oYqk6fotLcB46psyhq2L90U8LO3GfiJgv+bUcs/89uT2MaLWYdNDRrzkzaoiba2gb2lk7w8nkF8JxYOAyEBTjM1mw1Zc/f9YkGrfcsYZmM08/LP8MGwqrQlnT4M+9MQEolCxt8kKjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 SJ5PPFF330187AB.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::860) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 03:56:51 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::f099:a504:2ad6:1d12%5]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 03:56:51 +0000
Message-ID: <ae22e1df-c09c-4f8a-8010-41e542e4c663@intel.com>
Date: Mon, 21 Sep 2026 20:56:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
To: Tony Lindgren <tony.lindgren@linux.intel.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
	<seanjc@google.com>, Peter Xu <peterx@redhat.com>, Artem Bityutskiy
	<artem.bityutskiy@linux.intel.com>, Fabiano Rosas <farosas@suse.de>, "Jon
 Grimm" <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup Patel
	<anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	=?UTF-8?B?SmFrdWIgUsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, Vishal Annapurve
	<vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, "Kai
 Huang" <kai.huang@intel.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Peter Fang <peter.fang@intel.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
	"Xu Yilun" <yilun.xu@linux.intel.com>, <kvm@vger.kernel.org>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-3-tony.lindgren@linux.intel.com>
 <ab3c9e32-ab34-49bf-937a-4d3d736fb4dc@intel.com>
 <arDHbjcwaRFcHb08@tlindgre-MOBL1> <arDVIEobkRr3E7yS@tlindgre-MOBL1>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <arDVIEobkRr3E7yS@tlindgre-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:303:8d::33) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|SJ5PPFF330187AB:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3584ab-947c-4c9c-77a2-08df185d888f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|10067099003|56012099006|3023799007|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: 76ZLxNMj00OSG2fn6myk6bxGJfjU1fwnHmCa7y7gUzY2JjO95JjKQBGFLNJn1eLPlcky7mRu4MHmeCx1ljKROHv9PxNVipcMV8z6I/ovwiPHvLH+r66Slcy+zSUCbSD7DCMtzfK+QZ19SR8i4vOtP+wKaeeWjUyiGzZFu/nkzUK4q6s0T/nxkGTPrdzzcF0RlWz2oEAEEe0Ms6h1AzApaiVAh379YZDDPUm4xZjzO+fiuaVfqpyVlVXlRwsAQJ4MPHojDHjwZcczARdZXSq5aPz2CRMcvElygxq8Bf699mhAkJEc7GVLAIcXnHssj64gu0i0vV1V/wnygJGl33qnmof2VyTw0RH4wRuLEGVpPw9PYHg+Hi4cqmwtabpyZn6mv+Au+FOcami0HYkgVQOVx4bKCbSUXNL37lfeSanZwyzTo8EYgL9UnkDxWk7h2S+qO/3WE5HSI/7tKNkUaRY+s3e4rDP8iT5ZQ3IBTTdTsq1xXDDwmNTZZ5oVWtqRVfZD/de6oiGuJKFOiRvnfjKxQ/ISBK4njs4PSoNRbF7ekpcOokDwgTTtliOGAmiZE+fC9huL1m1vx0iolz3jcRHPXC3kkC7/XnURDAmIW70kfPQ+w7nVUYfzua6Y8CgSwX8OS7cuNertO6cqh3meSz3ySd+67ADADPgrVsK2q2TdKNI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(10067099003)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHFlZ3ZzV2dRemZzcTJwSHpESlIxTXZSZlhEek5JQ0kxWjQ2OWZCUG5rVGF5?=
 =?utf-8?B?L0lCQTdMS0h4NTN5VnJ2TmtMVXhVTmhoWHBMZHUzT1VkZFh4aXB6NmNZaElQ?=
 =?utf-8?B?Uys2NE9SYVRtYlZ0TjBEeUdkQ04vb2JPM09yNktpWVJwNUJqODJtUEJqc0Rr?=
 =?utf-8?B?c0RpTEtqQitLMDhJdmVnSFhhZXNvK0lVU1JTK2dnbHFKd2tKUXB1Z0gvd04r?=
 =?utf-8?B?bDhsQWF0am1LL0xXT0gzUHcvSDlWZFN1c3Y4WUZ2QXU2M3E1Tkl6R1k2c3Bq?=
 =?utf-8?B?QmFZSC9rQUMvNFMzZUh5S1RROUROdEJjNG5OU0s3UkV1ckxONWE3ZlNVRUxr?=
 =?utf-8?B?RGdWOE1sVzF0djRzOG9RSzJmUkVDWHJ6NHR3dkNHVDI2b2xHNndIUDJZZ1ZL?=
 =?utf-8?B?WGVhMmdpTUdiTWRjMWdWMi9UdXg4RHYyVUZodG9qYzQ3SFZoNklBREkvUFZu?=
 =?utf-8?B?WHZ2UWY3RUduOHRpL0VZTmpicTNaMVg5ZTZzdVdFMEZmeGs1TTlsSDM0NFho?=
 =?utf-8?B?a2R3aDlxQ2g5dEswSEkrY211TUFTOGYzbXlZb3EyTGFrYWM5S214Z3crKzBX?=
 =?utf-8?B?UXIyRXJTZWVKU2hqWURucXFEbXJXaDV3bzZ0K0hGL2pJMW1RTmRoMmZsM3dF?=
 =?utf-8?B?MTBxTUpVZGk5d0lKeWFKMk5LREdHMFlXaU9sOWxtT0l2V09kTGY0eCtlN1Ji?=
 =?utf-8?B?cWhIQTZwRHdLTFN4bHhuV1VsZHRKL1NxQUlDcyt5NDlVV0FqeFNRTmgySVdz?=
 =?utf-8?B?WGs0RDFuTUhwQ29lSGNmUHJKMUxoeFlUa1k2c2ErbEpna1dxZ3FJdlZRV3k3?=
 =?utf-8?B?RTB3VGIwaXgxMGNldEsrN1VTVjB4RGNENlpsQ2xuRUpWV0F4RnU2U2JxR1FJ?=
 =?utf-8?B?NjJtOEJRK2VMUHNrWHJIL0d6dFk5cHQxR2ZXUndjb1RmYjN0eGtRMVpta0xi?=
 =?utf-8?B?a0xLOC9LQ1dlNWFubGZxc1pxR0xRZ3ZuMi9hTlVYUWFnUXIrcVYzMWV2bHhG?=
 =?utf-8?B?QkNuSE1PTzdLRTFVbVR4elpCMU1GNmpFZ2t2REdhUzA0bEwyMjBmRFBkNlE4?=
 =?utf-8?B?SnZLK055a3IxS2RGWnNJU3VWRGRLcWdSL1MrWnVUMTBUS1hzbmFnVjVHOVpa?=
 =?utf-8?B?TUpDMmt5aEtOMXhMMWlvL0Y5OUE1OUlLNDhKVkZENEdwb0FoQmR5U2dqMVF3?=
 =?utf-8?B?c04zclZ6a0JPbUcxTG9YdWQwTWdvVXZyOXNHdXdSRGVRTk1mMWpQdjUxRkRM?=
 =?utf-8?B?UW5KT1ZqOWFLd1RnVzgvb1lXNnlqdEx0NHJHL1ZUL0kydkVtcEdsUXQ2T0Ry?=
 =?utf-8?B?NlVEZU13ZkpjcmxjRDEzc1h4M0NqT1pVdUtOcnZ4L1pPbjNURU1zenorQU1v?=
 =?utf-8?B?S3NrQ0dVc1FiY2dLdlVpb1hQeVU3aWxEeFVybFVWcEs5d3EydGZzdksrdkZ3?=
 =?utf-8?B?UlVsK0ZLSFJIdTRxYmQ1SzZZdk1qOUdybXpjQmcrWG5EK3hibFRQWlJJdTFN?=
 =?utf-8?B?aDF6ZDhjUFhuaXh6b0YvaUdMMXRodmZINUNSaFZ5cyttQjhPejNMaEJ2UDZW?=
 =?utf-8?B?djN4d05RK3dIV21sQUtacHZwL1dVeFUvcTdoNk1vazA4SVp3UkFyemQ3M2xw?=
 =?utf-8?B?bWxjYTZPMHpLMU9xUWJibEk0NDlaV1R3MmR0ejRyMTdaVFRuOHI5RW5BUXZ4?=
 =?utf-8?B?cjV4b3A4UXVCN0pJZkttZzdpSFR5NmNVL1krcW1UZDBZL3JhK1lrcGdaK0Rt?=
 =?utf-8?B?cHJTVGJzUldXdDlEZmQ5Q0pxYnZXY3ZoY1Y2TlU5bm5ybFVHOW1ZMHluS2JL?=
 =?utf-8?B?YXoyNlFCdVM5VnJ5Q080WjhqdVlVeWFGa2htaTRtQVVBTkk2NFExSHBpQitG?=
 =?utf-8?B?SGpjVzU4c01mQjdrSDJmRm1wOWdmUEdnb0V1dDBNUzlYc081VUxUWkR4bTdp?=
 =?utf-8?B?eWRyVXVJZUdRZlp0UGVwTEI1Vk9udjN0YTdjVFlybFJFd2ZvSXlhc0JxQ2l5?=
 =?utf-8?B?cnFxQXBTNnB3OWY3OEttdE0wREpTL1hvNVV4c25oM1JqczgzVGdVMHRBMitY?=
 =?utf-8?B?OVgxV21iUm02Z2hUa0xteWpTbWt5ZW9VSldMUjV3UGtCZmsyVVdYQWpCcnE1?=
 =?utf-8?B?TnFYd0FINEZqN0owZEZhWjBJbENvRWlnZklicTBwT05lRXY5ZmlSQVpseFBH?=
 =?utf-8?B?Wk5BZk5ISExlcFE1amE1Y2Zmc3NBQVI4TlFxOWdVRkR5Q3VwNGtUeE83VlV0?=
 =?utf-8?B?dVgzRzU2U3FkYS9wQUdwMVUxVXdIMWJITlo2eEMzMjJ1K0JlQWdCa3JzMTVo?=
 =?utf-8?B?Y0JSWk1sQjFOWThsbkQ2dy8rN09FblhwTmFNc0VYVXFURFlKSm03dz09?=
X-Exchange-RoutingPolicyChecked: MMet+zvQrm7jTlqVHZyUigRYGGL1Z5NCpkhaLPbc9xEArJw0uqb866/ejrralmIZkMxGzA7T4LF0taK7Z5vB3Zz4uL6d/h6dvPyGSIODD+X4a8ukYCU7cosco2XS6RZEhTmu1qp+PtqyuHpRxtsS9B48eBmMkDBmKDZTMqr+XVzO1nA6qzY5q5w8i6WsF0PRQIwaTrx7IVxy1dFZfUEzdO4Kh7KYNPiiefjDOsEH705nHSMgBS2iVH5QzZokm5yggkQT/uNfyj2KO6EvObCW8I5ZBXWICmxd5cyOhzbJvU6pVmJ5ktVRSVC/0UxWo0RoPSmgX89YLik3T4bdC2vabQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3584ab-947c-4c9c-77a2-08df185d888f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:56:51.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cstLkeIez82ZiW4H/hTOzlw6fw2EZrw7kUB12z0BcdaBcWZMoNyJha+v+ENluPznrCAR/Wt+kofPcgorDF7afw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF330187AB
X-OriginatorOrg: intel.com

On 9/20/26 11:56 PM, Tony Lindgren wrote:
> On Mon, Sep 21, 2026 at 08:58:17AM +0300, Tony Lindgren wrote:
>> On Thu, Sep 17, 2026 at 09:33:18PM -0700, Kishen Maloor wrote:
>>> On 8/31/26 12:13 AM, Tony Lindgren wrote:
>>>
>>> I was wondering how a vendor would use kvm_transfer_buffer for a command that
>>> passes an input and also returns an output. size can describe the input
>>> length or the space available for output, not both, so the kernel has no way to
>>> know how much it may write.
>>>
>>> Two suggestions below. They're orthogonal.
>>>
>>>> ...
>>>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>>>> index 5f6c1ce9673b7..d9291a8a97bb1 100644
>>>> --- a/arch/x86/include/asm/kvm_host.h
>>>> +++ b/arch/x86/include/asm/kvm_host.h
>>>> @@ -2010,6 +2010,8 @@ struct kvm_x86_ops {
>>>>  	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>>>>  	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
>>>>  	int (*gmem_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
>>>> +	bool (*cap_live_migration)(struct kvm *kvm);
>>>
>>> Should this return an 'int' specifying the maximum buffer size that the vendor impl
>>> requires/uses? Userspace can then learn this once.
>>
>> OK that sounds good to me. I assume you are thinking the maximum hardware
>> specific buffer size per thread? As in 512 * 4096 bytes for the TDX case?

Yeah, an upper bound on the buffer size, so 516 * 4096 (4 for the GPA+MAC lists 
and MBMD) in TDX. It could be a hint to userspace to size its buffers at the 
start. Though it would be up to userspace to decide how to use that information.

>>
>>>> +
>>>> +struct kvm_transfer_buffer {
>>>> +	__u64 address;
>>>> +	__u32 size;
>>>> +	__u32 reserved;
>>>> +};
>>>
>>> Should this struct include a 'capacity' field (u32) that is set on each command?
>>> It would be the number of bytes writable at address.
>>> size would be the input length on entry (0 if the command passes none), and the
>>> number of bytes produced on return (0 if none).
>>
>> Hmm so the transfer command return value can return how many bytes were
>> written of the input. But yeah we don't know how many bytes were written
>> back to the transfer buffer as result of the transfer command.

The transfer command return value could return how many bytes were written into the buffer.
But in an input-output call, the kernel handler wouldn't know how many bytes it could write,
or for that matter even how many pages to pin up front in case it needs to return an output
because 'size' couldn't simultaneously convey the input length and buffer capacity. That was
the gap that I thought a read-only 'capacity' field could bridge. Of course, this
assumes that the output is written in-place.

>>
>> How about if we add the bytes returned to the transfer struct? Then the
>> kvm_transfer_buffer can stay as just a buffer. 
> 
> Actually, for the possible cases with input+output, we could reserve space
> in the transfer struct for another struct kvm_transfer_buffer for the
> results?

Yes, say an 'in' and 'out' kvm_transfer_buffer inside struct kvm_migrate_cmd should
close this out and shouldn't require a 'capacity' field. Maybe we then establish this
convention:
- A non-zero 'size' on 'in' at call entry would signal that there is input.
- A non-zero 'size' on 'out' at call entry would convey the buffer capacity.
- A non-zero 'size' on 'out' at call exit would convey that there is output.
- A zeroed 'size' on 'out' at call exit would convey that there is no output.
