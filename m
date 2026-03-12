Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0738CFEE;
	Thu, 12 Mar 2026 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334588; cv=fail; b=jol7es8BFDKgnUZFVYBjjoSF02P8NIuLveoZBDBVjUnJNZBw7TnHZ+IsN+ONl266ojjFESkG4yf4YWN3WrdhRZnAmbv00cZUG6DOLtKuerlKzqXeFipNGQRRsvRP34tykO8prA7ioK4a/x/owtPX5p6ESIAkCw9i785baYzQIq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334588; c=relaxed/simple;
	bh=xB5vUdhRMppsOTBasfV13wA1bDy7X1evXD7lzFII+HM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IRsVN8F76V3UedfCbT/ykQtZSv6PDQUvICByKZKBPKFN86UL/XpQr8Dr5Ch4ceSwMD8eWXHe7PGS6XBD16JfLz226huQH9v6jEz7f6V86jXzHQcmnJLaoFIhpftJQTZNuZHSDjXak/mkhPTFoowJMFEaruadsoRD4QGZGWbSf3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/xEmJw6; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/xEmJw6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773334587; x=1804870587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xB5vUdhRMppsOTBasfV13wA1bDy7X1evXD7lzFII+HM=;
  b=n/xEmJw6bO+hJlpD2YI29zsLKXcbwKsn9oGEpMoVvrTSps626vkbUVcz
   ymA5wqsw+uD3rRR7ji02I9TsVDSH+n4mKAq1dUPpDXjptiGcj2Ln5EN0n
   fS5okjGsml7Db+TS1CVLU3lYPRz3DsMD9OIOL8vw+2qcZZUBmzVoeItwR
   4SrUdsi/AKpXHt1TDfhsPHSNdDI9Bwt+Gy43VX9RmvltTYKVp9P8TpSbi
   EsjkoBs8BWa28mx51lB7QzVhqCfNlRWynIKoOFrbTmIhwEKbs0fo5nMg/
   8tSfU6PcKowSjtZSEKI/oM2yjFXKm0I5XXtYWMpnXp4/V1v9HY6PvhCfI
   w==;
X-CSE-ConnectionGUID: iiJzan5HQ5eD+DAfdsMIrQ==
X-CSE-MsgGUID: /rycVlF8Q+W9XzdrjlSGnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85137321"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85137321"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:56:26 -0700
X-CSE-ConnectionGUID: kQL8EgSSTc6v/x9kNbDSwA==
X-CSE-MsgGUID: c0jeG1kOT06caBrxMVbGOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220141820"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 09:56:25 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 09:56:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 12 Mar 2026 09:56:25 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 12 Mar 2026 09:56:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJlBYGzE4AcOU8ru3f2GT6ZPGBkOKBN1sruk/w1uoBlhYfm62BS3B5ZDSR5ArGus7iwC7J0ctCB7OvlQzWvAV1Ej8GoKo9gNy0j83I5Zd+rK5VLv5uWpbLoDavlSZOJcuSZ+OTBmdyFFjULSz9H+jjJcFE2q6WNnwW4bFEPeVClc8q8jC5VEil1dW4ABhXRN/RswPjBC6Mx2RNLDTaC8d2rmImebHMfNiAeCdO6v7iBVHl2XPEZ6/iJC5lb/cKggBlJyG7qDNTx+RcleIU2r1SJYubSrVBJcVVQhyUjl0IDMaNm8gjmWH1+29OKlh8RqChaUYuzdNKxOGOiXu8tRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xB5vUdhRMppsOTBasfV13wA1bDy7X1evXD7lzFII+HM=;
 b=UYJdFtrlI1J8yfgpRzbohQlS+clE4BDxNxwTKQ4CyN6kN/nUrrfbBl0vuv9DhtFd2+mBj8LLb+s2/smgKB64UKdICKUer17heiRNDRoWYvar+AVHHAjYzkTibOh2BvBqu6hGlOMYeL1PnFNn2YPP7j4fQSrm9H748N9Eo7sYfcigNqwHkhvwT1sFaEf3+8wnRHsGFd2zSBSzRH1SdA2Ig0Yfo8Pzk54rHGvM9DOD/qznoO3N6EUY/hB9FQtIiW8EJipTtR3Kq8uLF9U4DUAl617/EMd7Mhe3saIRU4VNlQCduNBDA87+0Du89bye2yJ/6R4JxjzalCkkwxninZohJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS7PR11MB7905.namprd11.prod.outlook.com (2603:10b6:8:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 16:56:19 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9678.017; Thu, 12 Mar 2026
 16:56:19 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Gao, Chao" <chao.gao@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Chatre, Reinette" <reinette.chatre@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>, "Annapurve,
 Vishal" <vannapurve@google.com>, "sagis@google.com" <sagis@google.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "paulmck@kernel.org" <paulmck@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 10/24] x86/virt/seamldr: Allocate and populate a module
 update request
Thread-Topic: [PATCH v4 10/24] x86/virt/seamldr: Allocate and populate a
 module update request
Thread-Index: AQHcnCz7HfW6ZwGSD0K5vt40fbEWzLWqWIaAgADKVgCAACcUAA==
Date: Thu, 12 Mar 2026 16:56:19 +0000
Message-ID: <89d69e852d3d822b51d3623d02ef6637239ccad5.camel@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
	 <20260212143606.534586-11-chao.gao@intel.com>
	 <abIlr/gnH/Emc/9X@yzhao56-desk.sh.intel.com> <abLPaonGMoEm2GFg@intel.com>
In-Reply-To: <abLPaonGMoEm2GFg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS7PR11MB7905:EE_
x-ms-office365-filtering-correlation-id: 18aaeaa3-ad4c-4a8e-2a09-08de8058486d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: KjF3POUMAQisUvGpmh35mUDGQvBpv5sZUtOnJRLai+7zlT121zCLt7VERYPE6QYKCwenhS/Va04ul2dNU/nBrcYGUlKNhXaniYX3+t7sO6qaVWVR/e8DdZSgRMsHvmQXyrVqz9ZuHwbbhRHhbh2V42MClFZk3MTyZ7AUXBRD3Cemayf4ikGZq5xkGriPm6eZfEAQVJACN0FMiabS7njl4J9dvX1LAyRtR6YhwjorAapZRSDlB6r2C62jO80HgodJk82KEmZLq53qEeYGynL+LhvO5fOjLNGAA2XVG3Ibzy5HZL0q7OPCHv5Wd2PDGmIs7/zGCfxJOPvSQbRS2zOhrtlr/xrFY4gP2HHER9lOIsxpRGdRI6OvYSltcVxYML77paxPh4SdHp7tuYkd5ymDKFa52eaZSX9utkxL/T7GNg45kWd+99W3UgbeX0vgAn7Qo5QrinybX2VqG5w+DnvpbFgP+tREnxvUGiGaatId1Zn8IeTE8ABTyb7BEK89fEYiFJHnbHcCXWHuCt6mpmBaUWynLtK+NaWbHUzGXabBg5i8DqjUiX5X4QlVplZru+gjywuxUsO6LbaWYg/Yg66wkvTYpj2ikS/LWfdBfb12kyMND/kg2ncl/tQV7APdPuHyvVj8lLl3wmzcR9nWIovF8kOcxez9BHvnTgPIJ/yo15SAYCCUAUzaFf2mjRgKDUyf1VrwNiiGciXDYSCHrlnH96fweIhTRypgleeLj8g171U8x8mZTWgdOvhqj7Zg2U/uzZB5vf/g5lOsWm1DwiJvy+MErrV+PoPUEUEN/c+1mD4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjI2Z3E3aTcvTytMYTB3OFBJcnJ5VDhuZWxzVkpLSzJaTW1WSzZHY002VC9z?=
 =?utf-8?B?cmJDcFZrUTJkRlk3NEJNNTdPcUlmSUc4ZUNNV0Q4TW5tWmtZQ3pheEtsaDBS?=
 =?utf-8?B?ODVrTVQybVRVM2tJWHZFR3RhNjZ3MlN2Q202dXkwM3JPS0RjZm1SVXhESGo3?=
 =?utf-8?B?Y0ludXBsdjRRYklxb1N6Q05iamEvWk1BMEZMN1JnMUwycHI5TjNjMitFRmpU?=
 =?utf-8?B?bkRra1FHN2t5YVZjbE96Visva0lnd3ErVWRkM3Y1dmpyRjdnWHAvbnE4cWph?=
 =?utf-8?B?cmF5OENJZXFCT2s2My8xVkJ0MS9mb3ovWEhDbFJ3c09HQTZkUUF4MjdRL3Rt?=
 =?utf-8?B?VTNWVVprZFhCMEVVT00xZ1BIREkraHNBMmZiMkx3QkN0ZnlsRGViNHEyR2o2?=
 =?utf-8?B?Q2tpRlVnNmNUdDNQTlAwYjNXbXF3a2tOZCt0dEw4by9RaUs4eXZpblNBeHM5?=
 =?utf-8?B?c0VMN0ZFMjE4alp5MWlGNkJ0MXR0YjAzbTZ6OU90TXIwNC9INEVnY3pYMWdU?=
 =?utf-8?B?eVJWOTRNUnhpdXRPQ1pKZ1Z1L3VKZzRpeUNya2tRLzlWR3RLNGlRU0lnS0ZI?=
 =?utf-8?B?UlhJUEdrSVRqSWpXUlNMd2pmOWU1bUxwdUhkQzUrTHd5dmk3NWxIYzlvMCt3?=
 =?utf-8?B?NDZiUERQdjlwZTdlakNpd2xhZ3hBcVNQcFNMV2JVN2oraUhONFl4M0tCNHFK?=
 =?utf-8?B?RXVIa05KNFJIcit5MnlHbkthTmpKeXExODZKSFZxcDNDYkpGdmpqRUhjeHVZ?=
 =?utf-8?B?Z3JpNTh0M3RJaGkvOU9lTjhnODJWeXZ1WCtsTTgvL0pqSVpoeGRtdUJrTWV6?=
 =?utf-8?B?VVZlRHp1NThaVnc5Wmo4aWorZ2JRUTVNVjJuRFI0Zk84VHNjbWtzZVV4QUh2?=
 =?utf-8?B?NE9XOE9YVitsaWJBUGVWQ2xzQXUzRWlPNklObXNPKzNCQ2c5VTFIQUY0ZTFI?=
 =?utf-8?B?WjBQdGg4b29sdDMxYVljdlp5UGdDVjVHUmhlU3Y2MWtoNGtBMVQ3SUFZcFZN?=
 =?utf-8?B?YlNsTjA4eDhoR1g4TlBUOCtGYi9uNTRXV0tIYWd5dGYxek5vUmtMMjB5bUNF?=
 =?utf-8?B?QzdSWEZ2MDUvdTZ6bjY1NzZZRDl4SEQrUDFzZTVheHg3VmhzSHJuQXNKa1M3?=
 =?utf-8?B?d0o5RDBvUjVsSStOZHJtcmpyNmlqMFl5YVppazI5aHA0UnBJTjV1RzVJNkNM?=
 =?utf-8?B?QUd0ZmNoY2wzL2kxczJVNkZQelBxRFo0SWZteExMY2JkSVg5RGdPQkYzYkw1?=
 =?utf-8?B?UXdaSVQxQ24zdmR2d2gyWm4rSElSTnRDTEkvQmJScTkzY29NcEtPdlkwM2da?=
 =?utf-8?B?Tlh5QnkxU25CQXJiZVluVVkvNXoyNDZScEoxaGQxMUFuQkE4TUVZS240b2Zs?=
 =?utf-8?B?S0NSSXZCZ2FYajVtcDBEWUQ0TElHb1p0ZlBSSWVaVmlldzJLZjdDZ1d4U3dM?=
 =?utf-8?B?M0xncFJmRVN6bmdaZ1kvdDkyaFhOZEdWc3VlUG5yNDlMZjZPc0gzQ0V1dzhW?=
 =?utf-8?B?cTZza0E0b3drNDU2WnBBQVZpNVF4ckdnRHd6NVMwcy9BZVRoMEV5RVhPY2xJ?=
 =?utf-8?B?cDhCQnRJQmtaYldnNDVIUEZ4VVFnLzVtd1NZR2JkRjNadEdycUFJQlRzWFpX?=
 =?utf-8?B?Y2xrajJXaDFiamdMTDJDQ3EvUWwyTmMzRjhnMFFaK3dFZTFubWRVV21rZ1ph?=
 =?utf-8?B?ektaa2lRRkVpVDZEcVpkRXREN3YwdjFpbndWc0NjNzhYejRUUkk3S1hYNncr?=
 =?utf-8?B?QXBNNXQ0RHdpSEVrVzljcEtlNWM0bitBaU1UL3hWNS9WWVd0L0Z0ZzB3cVVH?=
 =?utf-8?B?STF5Q3FZd2tObHJEQy92VGlDd3hIZ2JVZEtsRUkyV3V1YjcxaG15aFVIVFZR?=
 =?utf-8?B?QjhtZXpueWo1aUJZTGJOWUxoSmlPck8rNGNEMGVJdWJuTWZEV2FkMUxFWXRy?=
 =?utf-8?B?S0N4NkxTTGVacmhBWndqUEF3NTlSZHUySjNyTUJuK2dEcFMyZXhUMjc1UUVr?=
 =?utf-8?B?MEk1WWpTYjJaa1RTOGhDbUMxeUNmNHlZSHEwY3VpbzJoMThFK2loajNUZkpE?=
 =?utf-8?B?SEVIa2cvUTRwZDJobW40d0x4NUc3OUZOTkFDVm5QUEFCcU1LdUh4M1hFWk04?=
 =?utf-8?B?OW4wTURhOUVhNjFrS29keEhQU1RyZGZZaUk4eWF1clJwaFp6L2ppZ0hvNnpW?=
 =?utf-8?B?cWFBZnlwZHh3WkdUL3BWdUVxbnpJRHdFcHdJYWljQlBuVTgrbHhtS1kyZDdX?=
 =?utf-8?B?RS9JL25jVVh1ZXFHRE1uRmtyTVdVZC9GdTgzUGtLVE8wUzVQUjNUUEx4U2pC?=
 =?utf-8?B?SFplVUxxZC9ta1JmK2RLem5Nb0g1enJrU3daUno0bkRIeTdTVnBMMGd4Y3dS?=
 =?utf-8?Q?8/bINYEoPthhwXhg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B21046AFD28C5489DEA6FAD0A54B7CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S93prKN1SVwWPsssMQLGNHQD9Cezto1UAdskq1pgboJl6E5+OW8dv+YVx5rRIwB/86B5GsX2Wk/ZgOJdbWALgdDB5KSt3uiHJQfVw6Q0KLfFB1bYYkRlpezD1SEcA8/RklVTJ9ShoYpz1Ol7jzBzLMORu+a+VP6ER3ay4lTHOJN6VLn86Q+Hw+tYz1B0MMNTQmYPhnoVJIBpPBFM8Rqqss/J+u8ip48lmz2gTjO/g4vCfbPZfMhpOfp0gfAMSmEN3Gyyfi+G99DxxkIDQdxEz1/TWDjsU9aQ3nz3dhEXzIaJxvAqUu8v4oMwrtM2DiSW2cUfkaWX0mKgSWMoM0ZkUQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18aaeaa3-ad4c-4a8e-2a09-08de8058486d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 16:56:19.3353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bE1JWZRsFwmoUkj30gmjPpP5qM3IKXnUFjuUD6TE8wDN1CuoragHi5P872IHA06GsuX+M+EL67IBI50f7oH68IrAV16JlbnQTO+ZYeb86TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDIyOjM2ICswODAwLCBDaGFvIEdhbyB3cm90ZToNCj4gPiA+
ICsJaWYgKGJsb2ItPnZlcnNpb24gIT0gMHgxMDApIHsNCj4gPiBEbyB3ZSBuZWVkIGEgbWFjcm8g
Zm9yIHRoaXMgMHgxMDA/DQo+IA0KPiBNYXliZSBub3QsIGFzIHRoaXMgaXMgYSBvbmUtb2ZmIGNo
ZWNrIChpLmUuLCB0aGUgdmVyc2lvbi9tYWNybyB3b24ndCBiZSB1c2VkDQo+IGFueXdoZXJlIGVs
c2UpLiBJZiBzb21lb25lIGhhcyBhIHN0cm9uZyBvcGluaW9uIG9uIHRoaXMsIEkgY2FuIGFkZCBv
bmUuDQoNClNlZW1zIGxpa2Uga2luZCBvZiBhIG1hZ2ljIG51bWJlciBhcyBpdCBpcy4gV2hhdCB3
b3VsZCB0aGUgbWFjcm8gbmFtZSBiZSwgYW5kDQp3b3VsZCBpdCBtYWtlIHRoZSBjb2RlIG1vcmUg
dW5kZXJzdGFuZGFibGU/DQo=
