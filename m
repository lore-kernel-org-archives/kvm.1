Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E683644C6
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786491155; cv=fail; b=JXD5lDOoh/JQsgkEYr/WiPu8Ehtmu7YeeNyG5kLCpDUwwGl7SPO6mKhWBbIaA2vDJ9lbixQNRwa00Tmj+bb54vwgL3DLdUfO3THdgCynKR+L2BZCZyCKW471oMo41FZEmZ73dVPzNesyFzwrUkYbZUs2Betev++jVTKCfajcNgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786491155; c=relaxed/simple;
	bh=0pTSVXBP6J8MCDjQxV0AZlzsBdvBUjRPwVFM2ZxcDtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VQcRyQYJvWuMu2aRWt9DkBlw4yYaDmSRi3geFD7v0yQfsTb+XIRnc0i27sdv5EjOSdDLwxuCfv0C9ffGzpovHewohv44Y3S+dbz9ac1Ba/lvMbPKS52ChJSZiW1CYTlqptARirXkoSQLqspgg+IbxLfNz1uHXAnymvbEaEeVibo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrMpYlZH; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrMpYlZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786491152; x=1818027152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0pTSVXBP6J8MCDjQxV0AZlzsBdvBUjRPwVFM2ZxcDtQ=;
  b=KrMpYlZHIZrAHpXiXXxkVfSBpZkJmlFg0nHEDjzRzS0ZAFhXy2V2NdXY
   IU2xuFns+OvavcCnf5VVUfdx/Ec2Fa38mHUEBWa734VV/HPLexi7foLt2
   0gru8dhQ/omDSRSD4Qeh+g2EWAbiLpllLEM5uZXPG+NjfbtuUCW6bZlae
   e8XIzbLWFuP7pkaUrpZBOZsfsCM2+r24/kX6fHV92qEcbM3SlUImgIWqQ
   pLCotHkSRl7U6dNX4dWn2GNju6xzGDsYsefE7/njsJY2TKTaoRo2X90kG
   PPsZsK4mCkObqzO3ty7oooo/m98Jn7E6xFoVE93tWile2WBJ7XyLbI1ho
   A==;
X-CSE-ConnectionGUID: nDGLfI9+TtS3xsQ6d9sm5A==
X-CSE-MsgGUID: 9G6U7bNvQAuVjrfx0XiAlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="104418803"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="104418803"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 16:32:32 -0700
X-CSE-ConnectionGUID: ADHH7huSTumd+vpq6k1YmA==
X-CSE-MsgGUID: t8gItk2iRjmuthH64VAkJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="259626703"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 16:32:31 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 16:32:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 16:32:31 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 16:32:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9sEtSflay5n6EeHdWD9bGZ1/pUFBymb/HO6N3xhBHZNTAsBf7W3T2Mx6wzmeguxO9mBs2QlwN5ntyw6u7CMVwFZ9h5bQWrG0NTMSlptkYTn6l+L+U7sHHKf0H6Yg5+Z0VHdZM2chrgI82qlB4D1gKXykftw1CWRS5M39Y6TO7bQJhzQzc1+36HqZ7CdzOI0dxAOET8dQVMy5J0Wp3RplKUz5LaYCdW9Ulr2AoQiUZXNQEDSTl+9IGy89bBjhlpu/sjxE4pQT+bnrLET26edDtk+Sd767nIdRruhiC8krYCx3f571YHhF9sRCHnSEOXH9HPFEFinpz8q/NzxbbABFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pTSVXBP6J8MCDjQxV0AZlzsBdvBUjRPwVFM2ZxcDtQ=;
 b=pJ/C4EJe0qlUlGXGd+k7WhGgckulV2DM+3vlcYYxIdDQ3CGg3yrCSPQ28/6a3LkApU30ViW95kZLAXX8vPSDSGeGox5mwwbGewv+AouDukwkpDSMTzflW3CJFviSan5/fWjTDhckhBbmkCYeUkJ5hcafXtERjYVVBwkJvQcO3tMD+cOM+vxJVWbxJK+SI0YGatMTpq6VFQY5G+tGVuDY1lrfPwyLe8U39eBJezhwSSAb55a6DOn66s8cf/guDAqryf/2gTRMKTu6h6r5PcE7u79urqTc2DHdwQVQV4jDVwlS275Qycx0Vo40BHKpUvAmQDCaJpr/2HzJ3x02g0ejdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5300.namprd11.prod.outlook.com (2603:10b6:610:bf::18)
 by LV2PR11MB9598.namprd11.prod.outlook.com (2603:10b6:408:379::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 23:32:26 +0000
Received: from CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c]) by CH0PR11MB5300.namprd11.prod.outlook.com
 ([fe80::3a08:e2e0:c8b9:7a7c%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 23:32:25 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>, "hao_zhang_kdev@163.com"
	<hao_zhang_kdev@163.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/4] KVM: x86: ioapic: Update remote_irr only after
 successful delivery
Thread-Topic: [PATCH v4 1/4] KVM: x86: ioapic: Update remote_irr only after
 successful delivery
Thread-Index: AQHdKWPlmGatbGHB40aAJs2gHjVUwLaYsZmAgADO7wA=
Date: Tue, 11 Aug 2026 23:32:25 +0000
Message-ID: <bf00c00ab342bf63af5b49fb549e00b9a5d4d2a9.camel@intel.com>
References: <anrQfoE8HRvsaao_@192.168.1.215>
	 <3b3db5de497f6196ddc17558b71aa746b0adf1e7.camel@intel.com>
In-Reply-To: <3b3db5de497f6196ddc17558b71aa746b0adf1e7.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5300:EE_|LV2PR11MB9598:EE_
x-ms-office365-filtering-correlation-id: 96c756e1-1009-4f52-9662-08def800cd19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|38070700021|11063799006|4143699003|56012099006|10067099003;
x-microsoft-antispam-message-info: DIOzFQk6KfbdDtykcgxSybv/exbURewLWpxvBsrW8Tus2spQXI2moI0D3KqtDLylLYweFdp9MrnVEO4j1zrb8FxvPMwiqTCpCiBMSpXdEIbz4QPlYjQ0pt5imzUE+kd+o2LWEdBpVfEe32KbjzR0uIVg2j3AB4iPZ6c/y+7Y5KvtO9M9GVqQN3e2WD6pnM5VN+O6QtoEFLNzNuOvkVOJg5Nex2h/zuT6t7lImrzcbJmHYFhgUUEPuc7eZjNaatflA6L4hlLvVgtQ200J25BAcw1HJ47N2F0gCwfLrfLaSabEox0ppEXHPcfBq77uUYqRa3AM5+km1172aXBtImBE/ZsTMc7UaYmJSKMrKurqtGv6t2AAOOiz6KmdgwIbd5bywXsyn8yoNGbZLUmLKlxppydl5Jjjy3QDC2JVEv7/NNDm91CI+Fz5VOcujpf6ugt/eZpX9Eg+Ra9FSJtAUGnOPL1Eyt2ePJc/p+Jn9SgGDtf/A7cmxY636xfh2lIBw2/HEliJ5Lslt+Q/b1Yq9sLVb+MlluhulTqnJIycV8k4D1ioB43YG4/H6FyYyKWOHlQpPtenY57t0apa8k3St5PU4l42OsgLsmh2UNomKzO8wmItLL0txFBIMhSsmszEbT+++aqlHd6SEQd17NHg92DZecelkPXj+0c4kaL6nKB8kXKKTKhs3UXRxKIYW/9zmJSrYah96wUXWBx4lIGRyOh29AhFyMoUmJV8/yO7UNgnnMk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5300.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGNjUDgxTFoxdlJsa05TeVY0Zk1nQUVoakFBK2gvai9qOXlVaUEzRDl5bkNG?=
 =?utf-8?B?Tnlwa1MvZTRRL0FUb1FUYTRTanFCSWhMb0ZWVlQyWXR6R255V2lTc1EzRU0z?=
 =?utf-8?B?bTMvRGlZWjlVYmdBN0RocEt5d2xKNlM1S2lqU2dHb2NsbUVnWkx0NGoyVnI1?=
 =?utf-8?B?Mml6bm1HeEZHYm95UGQwZllDSjNZNUJYZldQZGcwb1M4YXY4dEdmV0o5UUU0?=
 =?utf-8?B?WnpTaE1kQ0pabEl2azhkVXNpQ3JlaTVQZzFNWFdIc2pWWTdBRWdROTFoRG9i?=
 =?utf-8?B?QjBiM2lnZUcyVVlXbXJ4NVpCYVFxRHFhandWYlRDTExoSndCYjZYSnYyTGZV?=
 =?utf-8?B?QWJzOFhyVHkyblpUbVRvdmJvcXZMaHltTzlYNERzbE5sYzR5Vmh1bnJ5ZGpx?=
 =?utf-8?B?TTVqeGdLaVNKOStjRFdoMlZyU0lrVDFJWHYwSVRhclU4Q3RFUlVFVVU1S3RV?=
 =?utf-8?B?WE5lSlNrRmZRNkM1NUU3Tk5XR2o2SE1YakJXTk92V0lxRTA3UXpCT1l0T0VN?=
 =?utf-8?B?K0J1OWlNMWhSU1E3N09ROW90VFlJMTZBbGNMZndUcGg0Nkp5bTZVQThVaEdu?=
 =?utf-8?B?YXlYY3o3ZmZweU5iOGdydTF1ZURSd1FKLzFHQ08xZTNWZGNZTXlNUzhETnBu?=
 =?utf-8?B?VHV3VFNwdER0QjM0WjJGUzhiSjk4MVMvdFZqakJQdjFPK0VqMnVNVGhCSUE4?=
 =?utf-8?B?eXB3czc0MjRnS1pPVTJDaTF5VkxVc01pYUs3NXpoR1VaTjErZFUvdlNjV2J4?=
 =?utf-8?B?YlRUSkMrcFFZWGpkWXBKL3ZPd1NWR3BBZ0tlTVVUMHhaQUpwOXh2VUVZSHRm?=
 =?utf-8?B?YWtGaUlPS3lMeWVVL0IxZktRQk9zN2FuWXhHZVJaSWVOVmpKUGtWUTY5UGti?=
 =?utf-8?B?ZnZ4SXViVm5udThoRm41NHdkV2RkbnFJZmZuY0wySFRveFhJdTVqVnRaTUhD?=
 =?utf-8?B?WUtVNXNCckFSTjMwZDA0WmkwZHp1anJ5V0R5cENUVEpMY2I5dTdQb2d2NWc1?=
 =?utf-8?B?OWZ1QzRQUEVJUDNHTVp3M2R6Z2ZrVDlwc1BRbUhNWGFPak5IVHZsRk00M3Qv?=
 =?utf-8?B?V1F5bzV1eCtjMVdMNi8xWkZVUVoyMXRMSFY5TDFiTWZJdTNYK1NiakNWUDN5?=
 =?utf-8?B?M0d5V3FjMzIxK1RZNDJGM294SkNaNGlaL1k1OWwyYTBKQ2MySDhTeEJyZnZV?=
 =?utf-8?B?WTIzTkRLSG5tQ045UGxyZ1hkTU0waG1JVEZkYXpXcFVjT3F2YlJjMlNsVEZv?=
 =?utf-8?B?RXU5K1ZwYjNHamRkdHc2OU1MQ05Yb3I1TzRUQU1VTnJBcWNmRjVVYlhKUTFw?=
 =?utf-8?B?RmdCaWI1M0tTakhLY0VPb2FnblcwVTBESTJPOTBDOWo2blBxUzR1WFAzaHBl?=
 =?utf-8?B?VUNBV0hUSVFkUitoWWFHV0h6NTI1L2tjNG9ZWTVXM3pNdDN4UlVzWVRReG05?=
 =?utf-8?B?QTF3anRuaE9XazI3VURQeHZOTzVWS3NrNzhLdG0zMUlEMTZ2RU5yTjh2RW9L?=
 =?utf-8?B?VnhOdXdWZHpWR3Q1T2dJOHA2bWwvMEMvU0h5UGtVYlp0b3FrWWc2ZnhzeG5y?=
 =?utf-8?B?cGpibmFzU2RpZUxIcXB4aURhbnBqRk9RZkQzZ1RBaW9HMlFPWGZSZzlmSjRW?=
 =?utf-8?B?R0Y3dFpWQTdNMndKb0pFWndzcG03ZDRZcTFiK1ZFMkFYOEFiQ01BLzd5T05O?=
 =?utf-8?B?UFpFRVVZaXVvdDVONFhtbmVCbjV3enFCNUp1MHkrVy81bWpsNWMxQ0RpWHhJ?=
 =?utf-8?B?ZW43b1VtTzZ1b3AzQkU5RTBDZm9WdHZGeEVDMEluUHQ2M3dxV3U5YWErVkMv?=
 =?utf-8?B?dVh3U0lVSjJaT1ZxWkRiQUpvMGJUVWQxakJUOGRWdUp4WThMWktXeWtGTkRX?=
 =?utf-8?B?WHUwa25FLzFaMG9uN2Y1RWZkZFBWbEVIcFR2Ujh0SWpHVkRBaHl5ejR4MzhU?=
 =?utf-8?B?eWYwS2pCWURZaXlmbEo1eEs2SUtuY29ISXUxZUloN3FpMWs0Rmk2bnpSTlgx?=
 =?utf-8?B?S2xuR21uVmxhUzZyN00vWmFIQmZ2ajd3c0lUU0pXRzczckZZTTRaOHRIbFZx?=
 =?utf-8?B?ZEFKdG1ScmdxNnVTY1E0MG82alJocWVrNGJEZDQreXl2QjNwd04yZGZ2RWRp?=
 =?utf-8?B?bEovT245SGc3N3Bzdm84TjZlNjNITmlhVzU0VFV0a0Y0L2VQSE5uL2I1NFVJ?=
 =?utf-8?B?NDh5OHRtVnczaVRKUCs5Qlg5SnF0QWp5U1BMOFNVbnpDOVpqUEdvcExDSXlk?=
 =?utf-8?B?NGxnbSt6Z21YNTNtWGpXUCtSRGRkbUZ6NlU0NnB3MXRNWU95d2dBeEMrZ05s?=
 =?utf-8?B?R0hKUHlkZlVRRTh3bnZaUDJNbmJzbVdyT2xFSzUvZzFuNFNTZ3VEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CE827CDE34AF24397608AD2E1A59748@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AGei6Q7xXEU/VyX0i93hIjc0Z7j7geH9o2jWz7K0aPTw4QKiD4Nh0KJ8pRom+Ytha3NqF8C2FsHYmHMFKZfRPsJyMZGTQS+am85EOh6clfNiEUL2WvZoppvt+IQIInSCiTzpK5dY1mhtpwZXVEL95P6LwicwOG7WMs8bcikN+lkqyk4XCiAw7dw+q9HYnt7zQv9zcobH6oGfu23zdVm8N4LCF99GgkwVF0RlGCQv6wFwTj6K/tRrjbJrELKBND/m0UV48PG6nTtUUjw0LBpkWgkP2P6yQQFeKUlX+S/39h7RRpyscXmDDfpuAjWVSJChfAzlNxnQiLznm3k4amwWQg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5300.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c756e1-1009-4f52-9662-08def800cd19
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 23:32:25.7595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Z1qOk0WpTEeDgFVpyCY4D/KPBC6vhiTSpjiQRwToz4XATZreKs1EFKlb/mqXhYImB72vHwbb6sEtI3oeIUEJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB9598
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTExIGF0IDExOjExICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBUdWUsIDIwMjYtMDgtMTEgYXQgMTU6MzQgKzA4MDAsIEhhbyBaaGFuZyB3cm90ZToNCj4gPiBG
cm9tOiBIYW8gWmhhbmcgPHpoYW5naGFvMUBreWxpbm9zLmNuPg0KPiA+IA0KPiA+IFRoZSBJL08g
QVBJQyBzZXRzIHJlbW90ZV9pcnIgZm9yIGxldmVsLXRyaWdnZXJlZCBpbnRlcnJ1cHRzIHRoYXQg
aGF2ZQ0KPiA+IGJlZW4gYWNjZXB0ZWQgYnkgYSBsb2NhbCBBUElDIGFuZCBhcmUgd2FpdGluZyBm
b3IgYW4gRU9JLg0KPiA+IA0KPiA+IGlvYXBpY19zZXJ2aWNlKCkgY3VycmVudGx5IHRyZWF0cyBh
bnkgbm9uLXplcm8gcmV0dXJuIGZyb20NCj4gPiBrdm1faXJxX2RlbGl2ZXJ5X3RvX2FwaWMoKSBh
cyBzdWNjZXNzZnVsIGRlbGl2ZXJ5LiAgQnV0DQo+ID4ga3ZtX2lycV9kZWxpdmVyeV90b19hcGlj
KCkgcmV0dXJucyAtMSB3aGVuIG5vIGRlc3RpbmF0aW9uIGlzIGZvdW5kLg0KPiA+IFNldHRpbmcg
cmVtb3RlX2lyciBmb3IgdGhhdCBmYWlsZWQgZGVsaXZlcnkgbGVhdmVzIHRoZSBwaW4gYmxvY2tl
ZA0KPiA+IGZvcmV2ZXIgd2FpdGluZyBmb3IgYW4gRU9JIHRoYXQgd2lsbCBuZXZlciBiZSBnZW5l
cmF0ZWQuDQo+ID4gDQo+ID4gVXBkYXRlIHJlbW90ZV9pcnIgb25seSB3aGVuIHRoZSBkZWxpdmVy
eSByZXN1bHQgaXMgcG9zaXRpdmUsIGkuZS4gd2hlbg0KPiA+IGF0IGxlYXN0IG9uZSBsb2NhbCBB
UElDIGFjY2VwdGVkIHRoZSBpbnRlcnJ1cHQuDQo+ID4gDQo+ID4gRml4ZXM6IDQ5MjU2NjNhMDc5
YyAoIktWTTogUmVwb3J0IElSUSBpbmplY3Rpb24gc3RhdHVzIHRvIHVzZXJzcGFjZS4iKQ0KPiAN
Cj4gVGhlIGNvZGUgTEdUTSwgYnV0IEkgYW0gbm90IHN1cmUgdGhpcyBpcyB0aGUgcmlnaHQgY29t
bWl0IGZvciB0aGUgRml4ZXMgdGFnLg0KPiANCj4gTG9va2luZyBhdCB0aGUgcmVsZXZhbnQgZGlm
ZjoNCj4gDQo+ICtzdGF0aWMgaW50IGlvYXBpY19zZXJ2aWNlKHN0cnVjdCBrdm1faW9hcGljICpp
b2FwaWMsIHVuc2lnbmVkIGludCBpZHgpDQo+ICB7DQo+ICAgICAgICAgdW5pb24gaW9hcGljX3Jl
ZGlyX2VudHJ5ICpwZW50Ow0KPiArICAgICAgIGludCBpbmplY3RlZCA9IC0xOw0KPiAgDQo+ICAg
ICAgICAgcGVudCA9ICZpb2FwaWMtPnJlZGlydGJsW2lkeF07DQo+ICANCj4gICAgICAgICBpZiAo
IXBlbnQtPmZpZWxkcy5tYXNrKSB7DQo+IC0gICAgICAgICAgICAgICBpbnQgaW5qZWN0ZWQgPSBp
b2FwaWNfZGVsaXZlcihpb2FwaWMsIGlkeCk7DQo+ICsgICAgICAgICAgICAgICBpbmplY3RlZCA9
IGlvYXBpY19kZWxpdmVyKGlvYXBpYywgaWR4KTsNCj4gICAgICAgICAgICAgICAgIGlmIChpbmpl
Y3RlZCAmJiBwZW50LT5maWVsZHMudHJpZ19tb2RlID09IElPQVBJQ19MRVZFTF9UUklHKQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBwZW50LT5maWVsZHMucmVtb3RlX2lyciA9IDE7DQo+ICAg
ICAgICAgfQ0KPiANCj4gVGhpcyBjb21taXQgZGlkbid0IGNoYW5nZSBhbnkgbG9naWMgcmVsYXRl
ZCB0byByZW1vdGVfaXJyLCBzaW5jZSBpdCBkaWRuJ3QgdG91Y2gNCj4gaW9hcGljX2RlbGl2ZXIo
KSBhdCBhbGwuDQo+IA0KDQpJIGFza2VkIHRoZSBBSSB0byBkb3VibGUgY29uZmlybSB3aGF0IEkg
d2FzIHJlYWRpbmcgbGFzdCBuaWdodCwgYW5kIGluZGVlZCBJIGdvdA0KbWl4ZWQgdXAgYSBiaXQg
YW1vbmcgbXVsdGlwbGUgY29tbWl0cyBpbiBoaXN0b3J5Lg0KDQpGaXJzdGx5LCB0aGUgYWJvdmUg
Iml0IGRpZG4ndCB0b3VjaCBpb2FwaWNfZGVsaXZlcigpIGF0IGFsbCIgaXNuJ3QgdHJ1ZS4gIEl0
DQppbmRlZWQgaW50cm9kdWNlZCAnciA9IC0xJyBpbml0aWFsaXplciBhdCB0aGUgYmVnaW5uaW5n
IG9mIHRoZSBmdW5jdGlvbi4gIFdoaWxlDQpJIHdhcyByaWdodCBmb3IgIm5vIHRhcmdldCBvbiBk
ZXN0aW5hdGlvbiIgaXQgcmV0dXJucyAwIChidXQgbm90IC0xKSwgQUkgYWxzbw0KcG9pbnRlZCBv
dXQgdGhlcmUgYXJlIG90aGVyIGNhc2VzIHN1Y2ggYXMgaW52YWxpZCBkZWxpdmVyeV9tb2RlIHdo
aWNoIGNhbiBjYXVzZQ0KaW9hcGljX2RlbGl2ZXIoKSB0byByZXR1cm4gLTEuDQoNCkZXSVcsIEFJ
IGFsc28gZm91bmQgaXQgd2FzIGNvbW1pdCANCg0KICBhNTNjMTdkMjFjNDYgKCJLVk06IGlvYXBp
Yy9tc2kgaW50ZXJydXB0IGRlbGl2ZXJ5IGNvbnNvbGlkYXRpb24iKQ0KDQp3aGljaCBtYWRlIGlv
YXBpY19kZWxpdmVyKCkgcmV0dXJuIC0xIHdoZW4gIm5vIHRhcmdldCBvbiBkZXN0aW5hdGlvbiI6
DQoNCiAgICAgICAgaWYgKGZpbmRfZmlyc3RfYml0KGRlbGl2ZXJfYml0bWFzaywgS1ZNX01BWF9W
Q1BVUykgPj0gS1ZNX01BWF9WQ1BVUykgew0KICAgICAgICAgICAgICAgIGlvYXBpY19kZWJ1Zygi
bm8gdGFyZ2V0IG9uIGRlc3RpbmF0aW9uXG4iKTsNCiAgLSAgICAgICAgICAgICByZXR1cm4gMDsN
CiAgKyAgICAgICAgICAgICByZXR1cm4gcjsNCiAgICAgICAgfQ0KDQpTbyBJIGd1ZXNzIHlvdSBh
cmUgcmlnaHQsIDQ5MjU2NjNhMDc5YyBpcyB0aGUgcmlnaHQgb25lIHRvIGJsYW1lLCBidXQgbm90
IGR1ZSB0bw0KIm5vIHRhcmdldCBvbiBkZXN0aW5hdGlvbiIgY2FzZS4NCg0KQW55d2F5LCBJTUhP
IHdlIG1pZ2h0IGFsc28gd2FudCB0byBwdXQgc3VjaCBoaXN0b3J5IGRpZ2dpbmcgaW50byB0aGUg
Y2hhbmdlbG9nDQp0byBqdXN0aWZ5IHRoZSBGaXhlcyB0YWcsIHNvIHBlb3BsZSBjYW4gZWFzaWx5
IHNlZSB0aGUgcmVhc29uIGJlaGluZCBpdC4NCg0KVGhhdCBiZWluZyBzYWlkOg0KDQpSZXZpZXdl
ZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50ZWwuY29tPg0KDQoNCg==
