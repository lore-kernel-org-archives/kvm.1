Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA501244692;
	Wed,  7 Oct 2026 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791333167; cv=fail; b=oKYn4SOGQAcKmE0RbrixzlWeJDfOoJMk8kbb+8QzkF8BRBGh3LGDq/p1rLJBYrtjTjJQ0fTdpfVwOSs9cbGSBNH0T/Kw4wgoJzbIHRye3vZ/68Y9otohzhgZN3W1Pw24abM1rJrpNzbQOH2a51XjRzb/U+kX2R7jRondr72HkDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791333167; c=relaxed/simple;
	bh=sPITHly6lD+EqXbrkgz7BqeT2BdEaJagoGoALOcGCIs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sKKjcKWm583fDCfEkBHV3Wm3T6O8dcl4bk3LqnVIiHLnyYVH+oquCF763J1UVaUWRQ/P+m+N5OloQxCP3Dnp/yrEQnbQsHpNafA7D5LDDyfBvY2EK2bCFQ8/A2mkv4UrKYx51y44Jev0UaLB4YucAHw/9mObWR4dG1bxuSkprmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLIUGjJe; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLIUGjJe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791333166; x=1822869166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sPITHly6lD+EqXbrkgz7BqeT2BdEaJagoGoALOcGCIs=;
  b=JLIUGjJe3CbaJaz0XP/1xiWsi6KWHcB8995iALIKtEGzQCUWGMX9V2A4
   2Gqx/7vdFQDNJFrnVhkhrRsZ7xI0jWZv5czQ0Zlnt7OWS80Ykpv/VKnVk
   hhDSgPKl9XZMEbLbbX/a0jg/CO6/jZLwnprNjOsDCjfxpUl1fjQdtSOTr
   Vy1la2TOPcenb2FRMXXtVq+kXMz3soRBqO7/SSGN+8WerSjlDI0MKhjri
   D/WosZE71yG87vJP3KIGexnElxPGQfI3ihS+aLrG6IaOT49eaaH+23Cz4
   PwStNHfe3yCkyifRGE+rKGXF1W6qvuQm4LP154YuZ8HNbTe2UhlEuuHfe
   Q==;
X-CSE-ConnectionGUID: cvRfO99JRbaBNaeYdoqbgQ==
X-CSE-MsgGUID: Q6KbBgaSRK+K6fB26PWOlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="109530197"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="109530197"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 17:32:45 -0700
X-CSE-ConnectionGUID: TbDU9gWESXeoGUsjl5cIFg==
X-CSE-MsgGUID: nOwTJqsIRQquYWD1hLqXPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="276406733"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 17:32:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 17:32:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 17:32:44 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 17:32:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRuBdb5608m880u4cFWgFdZHWKEBid0mYz7gSeqUy72Gp3ZcDQ88+Bwur7cI0ITNtdIzyonEjx2GWuwbtpy+FXhxHAadaywUTEKE3VeAQjcqcO2GOj5NPIMV4Ei6NsGbjpQoG/79xBbabImNHqaoHcGoWMSTCSvhEib5mqQLmJLzpxBCe7Jnx8YeIbBYcOkgBXM2e6W/8JiFvtw20z40uU4/IUSMuu2nUXizM0QqkYs7eiRxpysU1h9iQ1StlYhMlB3pZSYkSFOKTGVJsIGGREj49kkZtkbN42/j4jsp8CZqTz5wbxO5l6U2gsH9N1+/owMgzLtAeqpG7QmQ7futew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPITHly6lD+EqXbrkgz7BqeT2BdEaJagoGoALOcGCIs=;
 b=qHrRHanGYzRx+zdInR52Q5zutf7MANHDr1e1qjat/ntNk1UbOYJ4DWbQrchi4vBoWqQNG5+XyqfvBbYAehiBePA6FhB7neMF96bZqjSKB9NmNhpH55jdYWfhPBQx0vk+5CdW1KaCrHHKTIhbHHwyMuEBtVxlZbD3yZztjn5l7ltGMi3wOgUj1SUUacq6LU4JIMr7zF+jiUoLlKFuYqqMObv1IJ7WGcgjD6hABB8ubBY7L0GujMcCanPunAYpc+XJrNlXSPuniP64rqE6lqDgItYaXv6j4TLiYCilNoHOanQCfuWlZIsElbErQ2GT2FeRpqjLzQDWHULL2QWlN62PrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by IA3PR11MB9255.namprd11.prod.outlook.com (2603:10b6:208:578::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 00:32:39 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0451.014; Wed, 7 Oct 2026
 00:32:39 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen, Dave"
	<dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>, "Zhao, Yan
 Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Du, Fan" <fan.du@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "tabba@google.com"
	<tabba@google.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "david@kernel.org"
	<david@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com"
	<michael.roth@amd.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Peng, Chao P" <chao.p.peng@intel.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "francescolavra.fl@gmail.com"
	<francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Chen, Farrah"
	<farrah.chen@intel.com>, "Gao, Chao" <chao.gao@intel.com>, "Miao, Jun"
	<jun.miao@intel.com>, "jgross@suse.com" <jgross@suse.com>,
	"pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 04/17] KVM: x86/mmu: Prevent huge page promotion for
 mirror roots in fault path
Thread-Topic: [PATCH v4 04/17] KVM: x86/mmu: Prevent huge page promotion for
 mirror roots in fault path
Thread-Index: AQHdTyky5qRvhSFqAEWTxJftTSk0CLbxSGMA
Date: Wed, 7 Oct 2026 00:32:38 +0000
Message-ID: <78144da219b6a2ee2eb10d6232e5a9eff63f0a5b.camel@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
	 <20260928090932.15535-1-yan.y.zhao@intel.com>
In-Reply-To: <20260928090932.15535-1-yan.y.zhao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|IA3PR11MB9255:EE_
x-ms-office365-filtering-correlation-id: 8aa134db-ce17-4a76-f352-08df240a7dd2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|38070700021|11063799006|56012099006|4143699003|22082099003|10067099003|18002099003;
x-microsoft-antispam-message-info: oxjekXCizBHJA5Lcg8B9lPgLu6SDgV97pb2zQvV3q5Vky9qNdAEcB+tFqM9snt3TvrXEvxYyT3aQ58SqOCYAIyqRjtaeqhJ6lPmHJdtAKQlhix+ufZDeH906dVv0z5yjWKOWKsj2CnIUhEHiuE4wNC//+pQvl/e/9/0vz2e6+gti3Uep5TnmoYEQsCW/xvD5I5lIkua3RB4zkujiF975hTgLoajbA76aMI1qTp05cG5m0/DQkt5+hqqycswoUGUaMIpPW/Tb+kpYRBwnvaYg+skq7+Nu4X9ZynkP8SlvkB8cvNLF9ejVMdOcxfcyA5R8Y5+64sPZ3o0P+WAsyRhtuXkHiKx7+m7lmeMyEjuz6F6rdPC3V7SS9076aD70z2bveuStmWh+vdAPrrQx8O/M4g9xLzU6E8+zbjnCdlVkfXsRA98Zx3eVTDsHGtFK5q4euO2GcuLDkhunBMmecofr8B/qoXUGcfkJALGRqnjtXYllaEvuPd5G7G/0vDbDwvQxdiWk4xszmD5kr6wlDcyWW6TySQEkKv98Ps2wMTvld6cAUJXBL9HEY1n2DUzGW2aLAB0NQfVja0y7ea6XVMOOgLEzxMG9/taYwAt8hR8py25PCSUBMbqgJFMshsJ1hrH8efZIVxMkWwsVsGZ08GCDINDsCiMFzZmaQXzrTbyBvndKJBxm/VB7WnT4v1a6g9+KrAlKhAszwQFsufitkChNyzOJW2ocHR7TkHNiLjgACcA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1ZrY0FwdkFrODhtZm5GUjhLaDJSRDdvNWltdG93VUJVOGJhREp2S29YRnQy?=
 =?utf-8?B?alhTUVJnSFRkRzFaMVlnY2svM215eFV1UDZvSWtOanZpTXl3WHBZWnFjQWZw?=
 =?utf-8?B?d3F2elBBUXBodUJZc1N3UUU1U1REUnlTNzBDb1ZMY2Y3RkZPd3NPQkRhc3l6?=
 =?utf-8?B?YXFray9CM3hYY1hQcnhFU3Zrbkt5MWI4d2o0b3VjN05MT1JVN0NkRUErOVg1?=
 =?utf-8?B?ZlZKNVREYU9tK0FZc0J0czdCdlB6cTdROVJpYzY4SDBnMkdKdDZ0ZGlBTnBs?=
 =?utf-8?B?MkkrYUxCUlJqSjZKa05kczNkUGM4eWc4NnFKNlhtaEc1ZEFlWHZnbFdkYmxW?=
 =?utf-8?B?UjlLQThMYURjQWpZTm9jbXJkSThDbGJpMU1DWm92VDE2U0R3bjdOclFVV2w4?=
 =?utf-8?B?aGZDRkpqWFpJMHBWUWFjS3JkZ244Zm5SdVMvM1ZXaDZvYnRoMDVoSWdTZEtJ?=
 =?utf-8?B?c3l2RTJCaFZHZnI4WThrbUFjT0ZSa3lEcW1CczltZDJmby9LZjQxY0lOUC9Y?=
 =?utf-8?B?YjYzaDZWci8weUlPY2cvTzRocUZlTWRHSktrRDJ4ODBVdlRsclN2bXBEUkZZ?=
 =?utf-8?B?MGJmci9rd3ZBMGFyZnREL1JjZjFDaEpWWGxpRWY0YWN6WmN4UUxLSEp0bnpz?=
 =?utf-8?B?ZlJJM2xDLzRUeGFXMEdyMHVCbFQ0Smo3VFVjdFkzRjJia25vL3JMUDRKeVM0?=
 =?utf-8?B?YTBjMTZnWEZKVk04QnFpYUpCeFZDa3hFRTFZMmpEMzVocTU2R0E0QUkreTJu?=
 =?utf-8?B?ck9JOERoZ0VXWmIrMW1JWGhPdFptTFh2bXg4TTZKQWVNYkxFZzZIbGw2c2dT?=
 =?utf-8?B?WU9UL3JyY3AxT3Z6R2cwK2l6RGtLTXJrQy81TTdnaVlmcFE0aDkwcC9wS1pi?=
 =?utf-8?B?bU05ZE1zRDNod2pZUzJIR0lJSGdsUUp2bTNaWlJCTjNpY0E1R2QxL3V2ekRn?=
 =?utf-8?B?YmNIcWJxSE1VK01JUmtHS2luWjB1RlIvNlhPL0RHbGV4VFRnK2xka0FpMGVQ?=
 =?utf-8?B?ZjZsNlpNcWJ2U1ovcUUzVlZIS24wMUUyUVNhb1hJQXlZZTlQSjQ5ZFhmMW9n?=
 =?utf-8?B?ODNMV2NKV1hLZGozWHJHOStGWHlJd1R5UHdiT0RzWVhGZFJMaXVXb24zMG8r?=
 =?utf-8?B?T0ZXdWJwL1lYdUZvNW15ZUNqbkYvbHhCejFXQ21RMTU5OEZZbTF6anJtL1JE?=
 =?utf-8?B?ZUIxME5RWkljRmVLWWl5RFNVeWhtdGt3WVpaVEIwWE1PcCtYN0I0NUdqRW5J?=
 =?utf-8?B?Uk9TRWI1eDh4bHpYV0xrY0srNkI4Kzlld2ljZDM4SzJRc3BzMWJHbUZCdFBu?=
 =?utf-8?B?d252cjRYV1JHR0N3NTZWaTFHeUJyTnltZUpHazBaMzlkbEpvQUtCYkNxUlUr?=
 =?utf-8?B?SjdldEdVT1B4MmhKV3BSZ1FsbXhLdFhXODZON2R5T1pUTzZrRm9sMEhVSzVS?=
 =?utf-8?B?Nkc0ZU9TYkhLWDkwM1M5ZkpTMU5RTVVBSFBVTzRCREwwQVJvWVBqL29XUUlH?=
 =?utf-8?B?amhoZlFkRUxlRFIyVUdrcHIrbmZUaVE4cGdVTTEvTHRMUnlydGZsd0FrOHBi?=
 =?utf-8?B?SDZGMXRRSkNJRW9PekdvNWx6amNLZjVqTy9OUi9TZEh5czkwNVlXeU5wZFZF?=
 =?utf-8?B?ZGJMU05VWnJFektCR0FEYllDME1kRXFDVHpzelE3aTRzQ21Sdm5nQWtyL3Nj?=
 =?utf-8?B?Q1FIWGMvSElsUlp0TWtRR3Q4VnZYckVvdXVEMVY1QzYrdzZXUmRibEs1VWdl?=
 =?utf-8?B?Wk8xcFl0RkUxTTk5K0ZBbWo2Q2dRVFkraTNMZ0M4UEUxV0RCZStQa2pKd2Za?=
 =?utf-8?B?OGJVU2xTOTJSMUUyTkRYUXQ2c3ZXRm83UUlJQW1Za0NjVEVObHU3ZEdWd082?=
 =?utf-8?B?aEJhTjNrcDIzOHdab0V5eE9HTTJjSEdqSTFEME1pOXl5VGFmczVwM3kzQytE?=
 =?utf-8?B?ZE14WjVLQzhwMHREcEFkbmlRcEhSeVBjMWVHclRCYlVEbU5NTzRHV3BqZEJN?=
 =?utf-8?B?Q1Fmdm5UVUhVZVM4S05kd21ESWF2bWw0QUV3TWtsa3duS0ZvOFBSbWs4SDNX?=
 =?utf-8?B?VWxiWXR1c3cwcW9ERHNUWE5uLzFQUHFPNGJBWUptbjFQcUhQeWJVTnpYNVY2?=
 =?utf-8?B?TjJKTjRkUkpTYnNWMktHUkU0WXhXK05oSytaQXd3Vkl6Y05reUdsaFhaNkR6?=
 =?utf-8?B?cTFveWhPUzdUNnZZdU8zSHpucW1nSXBDRE5rT3FqS0RGTjFqaUpxa1dkeXJS?=
 =?utf-8?B?RnFVQ3NuemhkclIvMkNLV1lkSCtyQ25pTFBMbDA1d0czY1ZlUTJFOTA4TG9l?=
 =?utf-8?B?cHBPN3JCeS9oWXRMTlZBdDlVcGNIek5zaThSVVFZMXVqdnpDZzBYM0o0TFQ4?=
 =?utf-8?Q?2x1J7RqtCWvlqPNE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33C1C0DB13028C4F8552F08D8A1C3610@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tpRJ3W+NOTAljPLhiFeFhhbAluAF2MFIZTzHUFZi/zAFCQUTRDuFJ8Qm1CH7y7XDvzRf7wwRDQ6/uWZ8B9BkaLz+gHqJp40Dqu/ArN+ONx84Z5Vc1kwtJf0wme22Q7Sz3HKIDAjalPQLoN+jjcvdThFd2jQoIAG9GBQl21TW0gtcOeXuYaKReEMnKcjyc4chD/Ju+Mp8HqAij1hbyjzkXosbxvbeHgCDpfpnNveFBtvySwwWchsoc46Kb5DMXLRMXdtNn6/dNxU6wp01LCzQYZXxXOtZKTnbGgKCIYE/jkPvk1QdXDDdMFgWE7f8DxE4OjtaFX+i6+tbNhAGQqrMhA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa134db-ce17-4a76-f352-08df240a7dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 00:32:38.9011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pAeSHEUckhLkJ07uDLgFQoNNMi50imx28BOvAV4FqR3RWvKgaaOj3lY0TDY1zHhxivWAddIHfkznE6C+olgVBxm4ExTnvlDuNw9j31dPUqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9255
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTA5LTI4IGF0IDE3OjA5ICswODAwLCBZYW4gWmhhbyB3cm90ZToNCj4gRnJv
bTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiANCj4gRGlz
YWxsb3cgaHVnZSBwYWdlIHByb21vdGlvbiBpbiB0aGUgVERQIE1NVSBmb3IgbWlycm9yIHJvb3Rz
IGFzIEtWTSBkb2Vzbid0DQo+IGN1cnJlbnRseSBzdXBwb3J0IHByb21vdGluZyBTLUVQVCBlbnRy
aWVzIGR1ZSB0byB0aGUgY29tcGxleGl0eSBpbmN1cnJlZA0KPiBieSB0aGUgVERYIG1vZHVsZSdz
IHJ1bGVzIGZvciBodWdlIHBhZ2UgcHJvbW90aW9uLg0KPiANCj4gwqAtIFRoZSBjdXJyZW50IFRE
WCBtb2R1bGUgcmVxdWlyZXMgYWxsIDRLQiBsZWFmcyB0byBiZSBlaXRoZXIgYWxsIFBFTkRJTkcN
Cj4gwqDCoCBvciBhbGwgQUNDRVBURUQgYmVmb3JlIGEgc3VjY2Vzc2Z1bCBwcm9tb3Rpb24gdG8g
Mk1CLiBUaGlzIHJlcXVpcmVtZW50DQo+IMKgwqAgcHJldmVudHMgc3VjY2Vzc2Z1bCBwYWdlIG1l
cmdpbmcgYWZ0ZXIgcGFydGlhbGx5IGNvbnZlcnRpbmcgYSAyTUINCj4gwqDCoCByYW5nZSBmcm9t
IHByaXZhdGUgdG8gc2hhcmVkIGFuZCB0aGVuIGJhY2sgdG8gcHJpdmF0ZSwgd2hpY2ggaXMgdGhl
DQo+IMKgwqAgcHJpbWFyeSBzY2VuYXJpbyBuZWNlc3NpdGF0aW5nIHBhZ2UgcHJvbW90aW9uLg0K
PiANCj4gwqAtIFRoZSBURFggbW9kdWxlIGVmZmVjdGl2ZWx5IHJlcXVpcmVzIGEgYnJlYWstYmVm
b3JlLW1ha2Ugc2VxdWVuY2UgKHRvDQo+IMKgwqAgc2F0aXNmeSBpdHMgVExCIGZsdXNoaW5nIHJ1
bGVzKSwgaS5lLiwgY3JlYXRlcyBhIHdpbmRvdyBvZiB0aW1lIHdoZXJlIGENCj4gwqDCoCBkaWZm
ZXJlbnQgdkNQVSBjYW4gZW5jb3VudGVyIGZhdWx0cyBvbiBhIFNQVEUgdGhhdCBLVk0gaXMgdHJ5
aW5nIHRvDQo+IMKgwqAgcHJvbW90ZSB0byBhIGh1Z2UgcGFnZS7CoCBUbyBhdm9pZCB1bmV4cGVj
dGVkIEJVU1kgZXJyb3JzLCBLVk0gd291bGQgbmVlZA0KPiDCoMKgIHRvIEZSRUVaRSB0aGUgbm9u
LWxlYWYgU1BURSBiZWZvcmUgcmVwbGFjaW5nIGl0IHdpdGggYSBodWdlIFNQVEUuDQo+IA0KPiBE
aXNhYmxlIGh1Z2UgcGFnZSBwcm9tb3Rpb24gZm9yIGFsbCBtYXAoKSBvcGVyYXRpb25zLCBhcyBz
dXBwb3J0aW5nIHBhZ2UNCj4gcHJvbW90aW9uIHdoZW4gYnVpbGRpbmcgdGhlIGluaXRpYWwgaW1h
Z2UgaXMgc3RpbGwgbm9uLXRyaXZpYWwsIGFuZCB0aGUNCj4gdmFzdCBtYWpvcml0eSBvZiBpbWFn
ZXMgYXJlIH40TUIgb3IgbGVzcywgaS5lLiwgdGhlIGJlbmVmaXQgb2YgY3JlYXRpbmcNCj4gaHVn
ZSBwYWdlcyBkdXJpbmcgVEQgYnVpbGQgdGltZSBpcyBtaW5pbWFsLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiBbc2Vh
bjogY2hlY2sgcm9vdCwgYWRkIGNvbW1lbnQsIHJld3JpdGUgY2hhbmdlbG9nXQ0KPiBTaWduZWQt
b2ZmLWJ5OiBTZWFuIENocmlzdG9waGVyc29uIDxzZWFuamNAZ29vZ2xlLmNvbT4NCj4gQ28tZGV2
ZWxvcGVkLWJ5OiBZYW4gWmhhbyA8eWFuLnkuemhhb0BpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IFlhbiBaaGFvIDx5YW4ueS56aGFvQGludGVsLmNvbT4NCj4gLS0tDQoNCkxHVE0uIEknbSBs
aXN0ZWQgYXMgdGhlIHBhdGNoIGF1dGhvciBJIHRoaW5rIGJlY2F1c2UgSSBzdWdnZXN0ZWQgaXQg
dmlhIGRpZmYsDQpidXQgZHVlIHRvIHRoZSBsb25naXNoIFNPQiBjaGFpbiBhZnRlciBoZXJlIGlz
IHRoaXMgdG9vOg0KDQpSZXZpZXdlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29t
YmVAaW50ZWwuY29tPg0K
