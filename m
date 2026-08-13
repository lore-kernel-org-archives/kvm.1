Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAB3242BA;
	Thu, 13 Aug 2026 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663082; cv=fail; b=eX/Al4TMrIcp/64W6l98NsyPQdUL1ZJ3JDmzEiFOmihzzElEPa3RqsgnzdGjBtLxvDKBhxYBxVywMjiLrQFZdU4xhwqs/NeUAe/veFMwAx7STyI+/E54f/1yA7c2baurcPjJrjG8MIIvPfu3ZR0zcILx/ESwj4rMYOcerWuaVRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663082; c=relaxed/simple;
	bh=Qz9gLdq6P9qqWSsSnPrcrX/KZmlw2mEjKffbllzFBLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d+h7XoA6fv37HrXNDU5TbxPY2YH+viCvysnsfHdkX07Am39SmXUBxzApNoT0ozhvM5wZRLpJjkXeKzP7q8DX+kuODGNazOoXjtp5GdFI/b2AyGSbKfWdbO+q9kucEf6euVm2kwzqxEhx3uqdB8Nq69w2ULCdUXeK+wuVtoYrcbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKls4xt9; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKls4xt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786663081; x=1818199081;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qz9gLdq6P9qqWSsSnPrcrX/KZmlw2mEjKffbllzFBLE=;
  b=FKls4xt9f2MImKhKbXPTUyi+NldXOaY7JiTNLlsBH9p2MVdQD4LhU8AG
   jDB5GZw8c6iFtJTVtQ/mInFl/ze0VNrz60wl9jCODov/H1ZOHz3KRlJgE
   BpuEgczWX5X354H4dz7Lz+VnuLSDMl4bKv/jVSeZlErHj33+5Fp/Jbewg
   gsYYsJVqEkgiLzbsGFyTvJNoafKAE4HmHA0NovWFq+XbMwNCq0X7KcPIk
   dek7ST4ukTQF3GYJSH7gYFwLQaCGJrzQ7Xc8jMmr9XBL6z4DLltLo7X1k
   xaYchd5//WnLn2mJUeA82AviQVTxHt5bzOtiTh8nmslNdHqJQXdv2mzOf
   g==;
X-CSE-ConnectionGUID: eh1I+uB/SISZZGPl9ucu/g==
X-CSE-MsgGUID: 3zwG7q0VTrq74DTbYlkw7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="90923368"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="90923368"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 16:18:01 -0700
X-CSE-ConnectionGUID: tmSXhE+wRou1r+2MUO29Ag==
X-CSE-MsgGUID: wxItB0hcRhSwe4jZcMhzPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="257846100"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 16:18:01 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 16:18:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 16:18:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 16:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5SrDqTQPn+wjsBiZx+SXJ4BJhzyI4SvNYcR9XAr1vdCL9whFdHcakk/i76+BcB/pEi91npWPN2TiG0QAe7bD5il1SwupaWqXuBbtMe9eMQjCFN2ySG/RQ3/CSfqpGHCE6sJDY1nsRaoffRGvpncK/70zYHJb4FA6cDpljCRIrXkPy12MCRqSUqaDqa/Fho05V4ZbdkSZBDnGhIIiooz1ai1T/0dFtl1ksa7Yal8IcsgQsuqREYGOXpbIOHZTRAzNCjjnoCM0XfwHaUjrZNcSXPxtY4+I2gXQ4e7UyBxfgI3pqAJFE0aB0yIgdpF0cTyxeFsuAfaRjx1Z4QgZpSuQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz9gLdq6P9qqWSsSnPrcrX/KZmlw2mEjKffbllzFBLE=;
 b=OSx8tbHh/6v//iOitgo59ga9jaApmamehFHR6pwLyqNC3O36ZLhyZJq5TCysvyqZ70p9Xz8MVIDCcGljnrsWZ0duXZs5MjT4bSPn7xgOgP6zUzczaDG9yNGXj07HemGgBMqtPLZfe0DMvFta41GTujjVxZq2U40C9AOuuqPw2QDDHLoaGZhDDO6FP3Hj0ZJv0TYILe2Ep9jKIrrhmP2KcojbJ45bwo1Cgx94mRt1H3ZbOcJm8hP1PBthRoM1T6LOpqa7vWD0HprI6COGAObchhhLonShLIe1Xb03db3nBcMqzfk7QV5aHxoBqgYj9SSfVV8r/CkNioeRHfyd3dJ0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS7PR11MB7781.namprd11.prod.outlook.com (2603:10b6:8:e1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.15; Thu, 13 Aug 2026 23:17:56 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 23:17:55 +0000
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
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v14 02/22] KVM: selftests: Update
 kvm_init_vm_address_properties() for TDX
Thread-Topic: [PATCH v14 02/22] KVM: selftests: Update
 kvm_init_vm_address_properties() for TDX
Thread-Index: AQHdGi/Zg3xYV9c3OE2B9SQEGKG/X7acv5GA
Date: Thu, 13 Aug 2026 23:17:55 +0000
Message-ID: <7327b274ef823e89cf664b33d94d9c2ba99c4ca5.camel@intel.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
	 <20260722-tdx-selftests-v14-2-15ad654a50db@google.com>
In-Reply-To: <20260722-tdx-selftests-v14-2-15ad654a50db@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS7PR11MB7781:EE_
x-ms-office365-filtering-correlation-id: 5f15df5d-c321-4a10-30c2-08def9911b6c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|11063799006|56012099006|4143699003|921020|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: jcVODVNsw75Ab0UIZulz5poX9JRUZSmqCnHXkwK4unNrGUCi2IViIUVTAMQr0KdNMx0IaW/UbxmJmzG58/R5pOlRGSeeJWv2cYLra/lGZSp7Gw759bBdBqIsCp7vVCNG4Ltn/J5yMqd/fbtOhh9vaAvKxZqQddOGYMVFAjUzNv1KTPdAI/VGqbs0nyCi08gA+XUzgzh93wwv+4Sokn1X6PCfTPgId3+WiBYBoW9IsoO4AaSQdb7xYgy76jWyouk4dDt9jzwho+XQZ3PnNrBf6uYWwSk/G/V2F5m+jFs6a2b55/Bai2l86ZILgereQl5j8eDYDQyUWdHSLKX2SFWgxjqZTolEHhCUnTQNkEvUMgHyCiV2A6Sptgd7sniP8d9ESH+2F2HW+zjQU7qFPD/tGQtT81PddgyAOfMS1VpVPodS2oLhVdZtdePRqYJ5jWQ6/58uHsf/gDK7lKQuSZXK4rpK0y0A7ESrw6JFAe284dpFzwtihkImWaGA2d75y2m84149ryv6BbOM7gNVc3bKsU9prm8//ejOC/EaBFgB3td8z+S5Z1tJv1IMJH7JQR5omTR6JSlovpoeC1+8ay2gOADRmIdVObe381YkBgrbwr+9Eay3a6OQ6175RGdYiSWsSGNS8upn8iluXDPO2wnmmJ18ux00hIo03KXVilkRge9xIrzdQMBuc5nejVkEo4Iloqc6lw6Op1DoBZO6Nzj8UOutrGP2YB+hAp7IbQGawphJi4nLwnz5r0CH6A9sE5dk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(921020)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHAxVG1PSVhnN21GK09OUE1VVGxVc3ZVK051eElKdi92RkZWNFR5UUFuWEhX?=
 =?utf-8?B?ZXRhYUN1N0RjZmJqMDBHclV4aWlrR1VPaDJ3aFhYL24xalBHRjBEL2pJeEdz?=
 =?utf-8?B?NEp1eVdtMDFxT003VXpUSFBGMVVGT1FFdWhtcm9iVThFQnVzeml5QnBjT2ZJ?=
 =?utf-8?B?U0hBWmFZMUFFQXJOclorOXRwYkFoU0cwYmpsaFFudERFR3dGRnBEdUtpSmls?=
 =?utf-8?B?dWRER1hzUW91R3hGd0tuOWVxSHBYZ1VuSHlUR1B6aC8xcFhSRkV2d3JEQS9W?=
 =?utf-8?B?b21JRjBWQUxKUCs5TWpZSDJUZXpnQkp0NGNMNUp0eDZOdnROYy8yRm9LNmYv?=
 =?utf-8?B?UmRjb1YvS0hRSmRGVGk0N1ZKd3NVMURsWU04ZFlRcFZNQmpFYkl4SjNuWUhE?=
 =?utf-8?B?bjNwN1ZvVnNHeWlESHY5bHFoM0xYZ0M3dXlxb29CWVdGeEJVSHJnTS9MZlNQ?=
 =?utf-8?B?RnpCQXVLaEF3ZDFSTzBBbHJWK3FwdVF5K29Qb2h1RWQ0em9GTHZxZUNmRTJx?=
 =?utf-8?B?TWUwWFBQUCtFUTZKeFF2QjJ6MXRxb1R4VkF4RUFxVlVMQXdzdWU1V2hDMkFW?=
 =?utf-8?B?dnJKcVZvR2wxM0hoSi9lUTZob09sY09DaWZyMERCWFQyT2dLYzM4SDR0T1lj?=
 =?utf-8?B?MzhPOC9ZZ2xtUWxBMHFNaUJnY3JjNWZHY2RGMDlyMXdxbUprT2FaRmRXNG9i?=
 =?utf-8?B?NmRKV3lsUlkwQkUvVkZGV3YxeDgxVWxicHVERFBlMG1kUDdGa2wzMWp0ZDdF?=
 =?utf-8?B?ZDNuMEp1NlhPTVRDQ1U0SlJkTEVwb1B6MzlVdEYvNk55WTFzeTJERHRXQ3R4?=
 =?utf-8?B?Mkw4Z0g4d1UxWTRvMWZlV2RiSXRxMGZDbnRsZlg3cUhCb1lLR1dLeDIwZmhO?=
 =?utf-8?B?aWxOUEtKRWlJNEdLdkZyekhlckRpamlRZDBGR2tTRTFhMG1qQkJKdVBsNFh0?=
 =?utf-8?B?WFBSU2hEdGpLaWdkSHI0eExXbHlaTGtObXNiaHAzUjQrQXVPRUVxbWprWDFT?=
 =?utf-8?B?OHRpT0FJdWFsbEtTalNzbjhxNkJURU55d0xDd3FhanRaWmYxcjBEVnlNSGZM?=
 =?utf-8?B?OWh1QWtGZkNBV2pnVXhXeC9zM3V0QUZoUmt1YmJOdjYzbEFyd0dJOElLQXVH?=
 =?utf-8?B?WnpGS1djbzRTOU55TTlHNlZ2cCtoamNWQVVHc2FNUjVGRUNhWjZBalpFTE5G?=
 =?utf-8?B?Y3JuRVNXcHlDRzQ1aDNFYWRkRnlYbXB3N2hmYVVlK29yTU5WQmVQMUNMQm44?=
 =?utf-8?B?TVUrQmFJcU1ZY255dHdPZ0R5WkpKbXVjTEVtRGFWU2tOcmprVzVpaWlxaGJP?=
 =?utf-8?B?NUcydVpqNlRIai9KOGNWaUpnZlMrajFsa28xb1pMUWRuRWFsd2p3VTBqNG9s?=
 =?utf-8?B?aWJSUjVvY1gvUEo3Y3BPR0l6TlhxejlIMU5sdkpDOXMzVTZoL0h2d0JMUTNz?=
 =?utf-8?B?b2pkVUFWRm5vR2thaGNnNlBzWlVMQ3doZ3ZGU05wYlI5MDNyeE5RL25WbkpY?=
 =?utf-8?B?SUtkdUtkQUVnbVh0QStTSnZ1RS95VSszODZBaE40cFk2NlFiL0R0bWNGRGJX?=
 =?utf-8?B?VWw3dkgzb0h1bGozeEVwTTM3U0FBK0o0Ynh1YXpBeTgxTG9aMlBVWjl3dTNT?=
 =?utf-8?B?bXNsdmJwTXJaSzhDYlUydmdMNVBMNjV3V3pxNE1sY3BwaVpnM1lLeVFTUUky?=
 =?utf-8?B?K2FTcDRPVWJocVd3UmZISkYrYzgwUjcvakw3R0w2eTZWMExhQ0FnOUJLYVRB?=
 =?utf-8?B?eXdOZzROZ2k3Qm9GSTFrKzhJWmowM2xhQU1kaCt0NDFCYWNIMDF0a2tKQUx6?=
 =?utf-8?B?Y2xwSzcya0hnUnV2Qk0ydDVSamtISS92UDJpRE9hblJmSld5VXhEVmFQVC96?=
 =?utf-8?B?S2xaRU1KdVZTTC9PdGI3RzBFeWxPcE9lU1dMdDJkZlBJZ3lDa0hJVDJkLy9G?=
 =?utf-8?B?cGd5WFh0ajd5OGZnOVdaTVRHRHA2ZWgycGNTMlpvY2d4VmtTMGhUNG1hMmo0?=
 =?utf-8?B?d0FYZzBERWU0dEY0MmM2TXJ1cnhyeGRWbmNEVGlla1lyT09JVDB4N3dGMTJ4?=
 =?utf-8?B?eW5sazlkZDA2QXhadXY1S2NHZW43RTdpOXp4cTgvdFYzdERjV280NzMrMDhX?=
 =?utf-8?B?VVM3NENDVldUWnVoQTh4cW1YU0FjYjZHM2NWaWNCWnV3VkRMS3dqZTQwVDNy?=
 =?utf-8?B?ZDhJRy93aWM5OTJWZUJibE9haHB6SkxtK3hxUjQzZ1UyRTNHWUsvMVJSOWxO?=
 =?utf-8?B?MEhIQzZPZUNOdldWWTFZNk5sT3ZjMndXRUw0RlpKcWplOXdFcHA4emZ2cE5H?=
 =?utf-8?B?N3BoM1Q0QkdtVHpDQWtqM0hMQzBNZ3pHRW5iL0tUaVhrOS92S2NXWWt6Ry9n?=
 =?utf-8?Q?UPgL+OFksf8wJadk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91FAF12EFEF0ED4899F936E0FBF27B4C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XWVwURcxoSg3uQhsT1oy9TFfamNCGFT4jq6QyaahBFxM9nEFHdpasqCYzgIpUeMFiZy6LqgsSbQ+SYBZD/twlCx6p0o840/qrBoDi9vFOycuH0RH1tY8ezuvD2idA/FbLm8t/puDo9hnRtAriIUTVU+pqY3Fdu6FncOhDntanFTgaLCN+m8/HX8xaJ+E9wUYvJHqA3GiQ50FhUGraL9rJRmIs74Xq/f61paoqFr0gq4I6npOwbd8eXq0GhxKvYwE4TaTnvqSg3Gc2SpSy/KgzlWh8EYIlhOSI5QqrHi7tkiczgQsBfEOMIXXtoaW6I0bc6xZc+FOZ8d0F6PMN+GwtA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f15df5d-c321-4a10-30c2-08def9911b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 23:17:55.8739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75rLBZrtqV4X9geVaI1TkwkIrGwz8SMw/I7VA++rA7oYseozLh8sQquw6xydEfNbku1/PTfoDeVQWAXXYHbJZPEe/IPL2i9WBNEwFXP+u9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7781
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDIzOjEzICswMDAwLCBMaXNhIFdhbmcgd3JvdGU6DQo+IEZy
b206IElzYWt1IFlhbWFoYXRhIDxpc2FrdS55YW1haGF0YUBpbnRlbC5jb20+DQo+IA0KPiBJbml0
aWFsaXplIHRoZSBURFggUy1iaXQgYW5kIHRoZSBHUEEgdGFnIG1hc2sgaW4NCj4ga3ZtX2luaXRf
dm1fYWRkcmVzc19wcm9wZXJ0aWVzKCkgZm9yIFREWCBWTXMsIHNpbWlsYXIgdG8gaG93IHRoZSBD
LWJpdA0KPiBpcyBpbml0aWFsaXplZCBmb3IgU0VWIFZNcy4NCj4gDQo+IFRoZSBURFggUy1iaXQg
aXMgdXNlZCB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIHNoYXJlZCBhbmQgcHJpdmF0ZSBndWVzdA0K
PiBwaHlzaWNhbCBhZGRyZXNzZXMuIEl0cyBwb3NpdGlvbiBpcyBkZXRlcm1pbmVkIGJ5IHRoZSBn
dWVzdCBwaHlzaWNhbA0KPiBhZGRyZXNzIHdpZHRoLCB3aGljaCBpcyBlaXRoZXIgNDggb3IgNTIg
Yml0cyBmb3IgY3VycmVudCBURFgNCj4gaW1wbGVtZW50YXRpb25zLg0KDQpTaW5jZSBTLWJpdD0x
IG1lYW5zIHNoYXJlZCBhbmQgQy1iaXQ9MSBtZWFucyBwcml2YXRlLCB3ZSBjYW4ndCBoYXZlIGEg
c2luZ2xlDQpiaXQuIEknZCBqdXN0aWZ5IHdoeSBhIHNlY29uZCBmaWVsZCBpcyBuZWVkZWQuIEZv
ciAidW50YWdnaW5nIiBHUEFzIHdlIGNvdWxkDQpoYXZlIGEgc2luZ2xlIGZpZWxkLCBidXQgdGhl
cmUgYXJlIG90aGVyIHVzYWdlcz8NCg0KPiANCj4gUmV2aWV3ZWQtYnk6IEJpbmJpbiBXdSA8Ymlu
YmluLnd1QGxpbnV4LmludGVsLmNvbT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBBZHJpYW4gSHVudGVy
IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWRyaWFuIEh1bnRl
ciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IElzYWt1IFlhbWFo
YXRhIDxpc2FrdS55YW1haGF0YUBpbnRlbC5jb20+DQo+IENvLWRldmVsb3BlZC1ieTogU2FnaSBT
aGFoYXIgPHNhZ2lzQGdvb2dsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgU2hhaGFyIDxz
YWdpc0Bnb29nbGUuY29tPg0KPiBSZXZpZXdlZC1ieTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50
ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaXNhIFdhbmcgPHd5aWhhbkBnb29nbGUuY29tPg0K
PiBSZXZpZXdlZC1ieTogWGlhb3lhbyBMaSA8eGlhb3lhby5saUBpbnRlbC5jb20+DQo+IC0tLQ0K
Tml0OiB0aGVzZSBhcmUgbm90IG9yZGVyZWQgY29ycmVjdGx5LiBJIHRoaW5rIEtWTSBwcmVmZXJz
IHRoZSBvcmRlciBpbjoNCkRvY3VtZW50YXRpb24vcHJvY2Vzcy9tYWludGFpbmVyLXRpcC5yc3QN
Cg0KQnV0IEkgdGhpbmsgYXQgbGVhc3QgdGhlIFJCcyBjYW4gYmUgZ3JvdXBlZCB0b2dldGhlci4g
QWxzby4uLiBjYW4ndCByZWFsbHkgcG9pbnQNCmZpbmdlcnMgaGVyZSwgYnV0IHRoYXQgaXMgYSBm
YWlyIGFtb3VudCBvZiBvZiBwYXRjaCBoaXN0b3J5Lg0K
