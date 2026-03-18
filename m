Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3AB2D73AD;
	Wed, 18 Mar 2026 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869876; cv=fail; b=j5YQ9cOYac+ubeFcFHzYMqCiyLPeFcWQFw93Q25Q+TSusb3NJ44FUOMt9xTvovtp+6Wghswpt24HnVNcWq+mzntTyyFVvPJC4JG/Qd0PXfi33D4wD8aKmlghSfGd1+JieG0dj4khj54Px0hsXG43kb2h3zQ6FZjdkI0BD6LMLVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869876; c=relaxed/simple;
	bh=1UbF8hWyGvj/Mq/zKPEipei1tJg4w9u3CWtVOflJggc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gMaIPhCqIpdRMPtbMRDBFrC7XzAPnJJLCd1jEhhWOBC3PLDqIEt+sx1R9pPeY7Hsz81tN2S6dg//RT/6DTfJPFTMOPJmxIb3AAYXD+tLI+3N7bs/mu2yD+QVQ/JqT/D6XhBfNdNrSNNLYAP6jvZBookY7YsfyERg1kkhJCodf9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DiXG0o2m; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DiXG0o2m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773869874; x=1805405874;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1UbF8hWyGvj/Mq/zKPEipei1tJg4w9u3CWtVOflJggc=;
  b=DiXG0o2m4copBLS2LddnolEv7aHWpAyKI5wDrqQfpWXNDdjhL7eWKUK0
   rY4zj7ujA9tVRtn3Gms7au6RhP+c7CAFOBxeYNNjzAfuFhV0h1mv2/qrh
   xQqF6wsTrLeAf0tHox4Wi2aqbueocjzZB6lKFXbzUMgpWGRMoPFQ0v6kA
   3p/BQYLmTVY4FDejOYD4sy6ofJ9dpPRLxn41TeeNxZM3ejCPMFX5cfi7m
   rfrBkqwG14zWNof8mQu+2+CTnWd+bdVMPTEMwW40oPIMq8dKHsN7PexR9
   S9Km/L6NBUFHeUJIsm38LHyLj/85yQg6V1A202yeolFMZNeE2tiX8nfUR
   g==;
X-CSE-ConnectionGUID: sgv+W+Z0T8avmgw6/RaL0g==
X-CSE-MsgGUID: Q/gA2AHyQCC8sRj5c8OUoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="100395948"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="100395948"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 14:37:53 -0700
X-CSE-ConnectionGUID: 53mZIud6SdylaZ3MZAX37A==
X-CSE-MsgGUID: jddQ6ci+Sl2htLnDW9ZXgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="260654116"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 14:37:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 14:37:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 14:37:52 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 14:37:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYZEINt47BrwYzAw9ynhGH7fX53J8XFvw+x5S2IYCbV0WV+4I/XHQjinE4Qj5S6OwbAqCCliGIS0bH9rOVZ8ZvUdB7LlXYiXI9+N9TPBlVjD9nMLvaNppaJ5WnG+wDyBG8niIaYoqaeTszSSPejWXRU0iE+HkwPuoGogXyVBh4M3MwFlH/6mxN1PQQJy6KFLKGwE0NBPIOJCjrBs3+NpgD6afqL4oW6OGBE1pOx/e1ms2sckAiIgKUZYIO0FAN8Kv8zMecA8tN+f8COAKgkZf+iQLi9hTE27xGg7toxxfMBbsZ/DBJiLH4Oeqph2G78rvZt4E+d6xaAtEiY6ZNd93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UbF8hWyGvj/Mq/zKPEipei1tJg4w9u3CWtVOflJggc=;
 b=DbU8SClDIeVevAyQnvZqZfYfNSBgXskwiM319RtuhYdxyKxkl3c4EEoETBYpo++2D6eo9PHTvCzMI3I2mq1VkHMHsIakBo88k1iw3c06YSaPfnPBidkTFxvSrV3mYoByuqS5RXxntvDXJJiH1goKfdUvJqzfSKLyE107Nqnp9DbHENJFfMJuFK3v4SaQG0u5q9gNmlqUvSUg7/PW7yMwPu3mp8FWW/EXYDuUYEWIn6MlKQl8LXBCdYKVOQ9ixbB0VHGgDoOxkuniKiqC1+bFWp4Zn8ippkMTtm7/DZzOsx3TopI9iwvwgJhZTXxKHcTsAmkOxaWOu3eNndK9t9y1Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Wed, 18 Mar 2026 21:37:44 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 21:37:44 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Gao, Chao" <chao.gao@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"Chatre, Reinette" <reinette.chatre@intel.com>, "Weiny, Ira"
	<ira.weiny@intel.com>, "binbin.wu@linux.intel.com"
	<binbin.wu@linux.intel.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tony.lindgren@linux.intel.com"
	<tony.lindgren@linux.intel.com>, "sagis@google.com" <sagis@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
	"yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "Williams, Dan J"
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v5 03/22] coco/tdx-host: Expose TDX module version
Thread-Topic: [PATCH v5 03/22] coco/tdx-host: Expose TDX module version
Thread-Index: AQHctIP8VaXivF/HGkCQ/l/wV62pN7W01dwA
Date: Wed, 18 Mar 2026 21:37:43 +0000
Message-ID: <799e70f390716014921934d65a67bf61ca65b6cf.camel@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
	 <20260315135920.354657-4-chao.gao@intel.com>
In-Reply-To: <20260315135920.354657-4-chao.gao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|BL3PR11MB6508:EE_
x-ms-office365-filtering-correlation-id: d33d63fc-94de-4c94-3d7b-08de853696bf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: YaBvd1K5e5dLDvvkQeAcEsa1UgK3G+SMlqbmxl2LFmtjB0g4M9S3KCfxs/bcvS3rsZ9yuoPp6ghe+Rj6ujVD2aOiLhC5VMT/PAGs55rkrGaXeh2QQJqlNrKPX9LT93QhIdsjXRU7h37xcroBshY16Ri8wngJLTUlZTCm6sflcdcoGqq5ZK+i7h7etSGAud0yiv4Mw9C0/xfu93dKaZUYzWisRKcQKNMiLcRnEQsMiPz0iHpot95SHN/Iwnl/KljF+PUjsyagrF+jnU1ZqZu94HDNuV1ntlSU6HLPPq8vAmRftKLRHfGal8rUXFzilouzp3TUBM6ucsM8ElxSiuqILz/4rzJBAK7k8ETWpym8bNAmBmtRsNqvru/Ts3J+wEzAV8TCrJuScxIOcKuifEcIKy0hiZaXrMWnrNqY2BLWtXnlB6wEfdblchUkxWCIAxp8IjuiC9nMO/WtNo2TrqB0r0pG2oYo6cd1JmHZeX0mP/Ri6ukKftqfF0WX0i2ZiIJBAVmjbYUwGpN2qJE72bfCns3uxPfbV4jLgPiIsMpScKka3sdT52Vowr3Atywe/s7M9SjsgkjGesuCGANDS+AV+Rlr+9W78Mc/c5FNis6VEvXQ5F4dlm3LU/tSZiQEby/vnNvMQEOQu6lEALwxg+Nkfn1NqmZa/aij+N7xWBHCc9mAfC7GpwZWkNelig9iV3NhpM7his1tk3ijkmKEOs/HdvrMje7ao2z2ujiczN3lPvlhdH39ORiG9nhYjep9+cyxpl883K+QmOsOunWpDysrl32lAmWcS2Iy+6w9OA0yBAU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2FEb3ErbXg0NEJwOXRpRHZ3OG9OQ3dOcHVMMll0WEhmbEllTGVRN2NXaGc1?=
 =?utf-8?B?NXhqS2N4cGNBRWZId3BiWWFYMUFPdDl6VUpma0hOTXJGQm9TODRsREM5d1Iv?=
 =?utf-8?B?dFhuSTBmc0V1bWxVWlZuZGN3TkZiblE4aGlIc1BLNmRYSmtjSW9UUll0QTVs?=
 =?utf-8?B?Mk1oc2pCMVBqZ2M2WFpTQ3RLUnYzYnJQek1Lbyt4bjUyMXl0NUJqQmZEVUlz?=
 =?utf-8?B?TGFCMlYwOEVFclRpcnFLVloweWI2Y0U2SGQ1bk9HWE5XOXhRSFl5cnM1Q3FC?=
 =?utf-8?B?VFBmcUllMjdvSmJvNGVrZVRsYVg5TjkvMS9mbmZYVXhoblhHTk9HSTBORFVX?=
 =?utf-8?B?eVQrUjBKd0RoQW9NcHBsTVBxQ0pGbk5zSXFpUU40dHRKU0tZMExlN0llS2k3?=
 =?utf-8?B?WG82N0llWlNDUndrcDlKMVNvMVBXZitxNThIc0VES1RkQmZyVVhYLzk0UVZR?=
 =?utf-8?B?OS9YUWpRRzJwL25BUmZaakt3T3NCM3NMN0FoOFZMTEU4YWFGNFFrbE83cnNy?=
 =?utf-8?B?UmoveG5wNjFEUjlpRzFKR2JvVTlNN0NHNlVKUjUwY1M1NTZmN2xtcjFuK3Ix?=
 =?utf-8?B?Q0VMREZTeVI5SmJtak0ySW14Nk9idlFlNi8zMXZlNWZ2WFI1bEViNVpvazRt?=
 =?utf-8?B?TkNvZTBsMnd3ci9zV3RiMXp0WkdhODEzdHc0Uno4dFdDclBkNVc5SnVBRjZx?=
 =?utf-8?B?UmhQMjA3bkZQNEN3cTQ1UFphS2YxMjJtR2hUTisvSDBia0J3MlFNU1IwK2lK?=
 =?utf-8?B?dzFRandLTVVtOHpKNXVxS05WT1NOTEwwUlpDejVhci80aUN5WFVsQ3NObGVK?=
 =?utf-8?B?Vmcxb0hXbkVxNHluRmxPWXRNQ200MkhtZ1ZNcGZzM1pZVjBMWHdiTzNFMjd1?=
 =?utf-8?B?NkQ3ZVN3L0Y3blcrempGT3NqMGZLY1pvOGNSNFBPZzIxZFFaWFBvRkxXRERx?=
 =?utf-8?B?SzgxRFFJbFdxalRDR0VmVUc1Q21DWHBxRFZXaWdTSER0ZlNVdFpOR0UxdWJQ?=
 =?utf-8?B?RVl6eVZ6cFNpWSt5Zmg3b29FalpKWDRLT1ZNVGs2d1Vlbmt2RFIvU1JnZUMr?=
 =?utf-8?B?dkFSRGR2UjVTWXp0cUZpcll3TDR5SDdHMDlJZHQ2cFQrSWUwK3VQd1RhL2c2?=
 =?utf-8?B?Y045c0FoQkVaTWtpdDhkQVM0bmhpU0FkYjJ0R0IvdGdzdk04SFFUeEdRRGFt?=
 =?utf-8?B?N291bCtTaVFuRXp0TEgxaElQdUJodGluMXF0cjJ6N2FPeXIvT3ZGYWp5cC9m?=
 =?utf-8?B?UHpPKzVIYU5QcXE2MWxKMFBVZWNibkdjaW5zQ0JGcnJJU3NoMmxmbmdrQzVt?=
 =?utf-8?B?TFFYa25QeElHUm9JUXhCVzJwOWRlL2tOWlFralo0bDI5RTN6SW9oUFN4ZVYr?=
 =?utf-8?B?aVdVNldvTnBpaDBsdE5wSHloQ0MvNlFUMTZmNTB3WDNrTUM2aXgreHJaWW12?=
 =?utf-8?B?ZllJOHpKVGd4WWgxK1VrTU41ekRWUXRvQTBkYWpDNGhVbFk2Mk1MSHdGMnlZ?=
 =?utf-8?B?cUlQZEhHSnhPU1NRNmlWU2ljWEFrM09jN0pURDlpQnZFMVExNERmb290Y2M2?=
 =?utf-8?B?T0M0L2ZjaURuN0loQjFqV0VIWENXVXRhRURaNmVlV1BXUXZnRDlEQXJpYkJ6?=
 =?utf-8?B?VGlpRFNuaFNPcGJTK1l0VmxXUGdKOStINlREYXZ4OFNWdG5IZ0xpN2tvVFdt?=
 =?utf-8?B?YUNCcUJTVno5YlVDWHFZNktGOGVqQWlrTElETUJQM0NjcVFxOVMrWHhhYnFY?=
 =?utf-8?B?UVVJNnR5K0RzRDgwWWNSOTMrbVdOTnFTS0ttdENBMHVJUC9lR2psZnZNaDJt?=
 =?utf-8?B?bmpwWWlBUWc2c3p4N3poQ3RJcjJIdk9na1N5TVRwWmV1UGJnb0dqallXMG9h?=
 =?utf-8?B?djE3OFJvYmtzRjN2a2t1OXNzMHBhQ09HeXcycG1CdFpQajZDeVRFNzlub0dL?=
 =?utf-8?B?SkcvemlpZGZGVElQVHV2ZjQ1d1RiYzB0MFZjbGdKRmw4QlVSN3dzb1pGUy9T?=
 =?utf-8?B?OWt3VW95RXFDTUUzS1ZzMHFHZG02c3RtVGo0YUVqd3dUUkN3SkIyV3RQZGN6?=
 =?utf-8?B?RTY5V2Y4a2lOK2svTHp4VmEwMTNzckY1SlJRQmVUSGk2MU13eXFxOThPRXZ4?=
 =?utf-8?B?anhGOTlGc2N2U0lMcGVMQWpaZnhHUTduN2trSy9NazhEeXZqenByWVFvNDlW?=
 =?utf-8?B?NWtrZTFnLzdXZElueWRiS2RxY3drODhjWk4vZnh5MGJFblhrc3Y4MUVzRHAz?=
 =?utf-8?B?c041dm9xMklCMlhMcGFwZVFZUDM4eEN5c2JPdU03Vm9PTFRVcVRYMXpzRXF6?=
 =?utf-8?B?bHNJQ3pUSk1nMlVjV3lKUi8zZ1B5blNIR0pZcHU4SS9oWUlnSVRrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C70307C65C60D44D821B876B3D761F80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UPTGrA7FgI39TUMfbkMrS/mMvyW5twg2CwsT7QC+q7uY7gq7UiOVNvfgcJSlEFYyj5gtoMc2ICEy4xuixj3PjfGjwzp55aXYyaZDr9kmrooDjS7giKtCcRYZowA26eNZPFbhhmgDi/FI8xF2VGe0UfiHJ/tY1ZfD4iuy9KruantnQ2UCDoZjUvByHiqS0+W743KTMISV59ph+FMN3QTNcCOBXGjZSwEgMso9AG83RELdTH5VS2uOI1mdbhsEOGnWVX79K9dkAO7kI+2fGEAMrvCyradS+lBhE8ztQHwmg5hs4J5qFFAQPtjaTGyk2MGUiUK1HkPUZYFHyx/Q6LIp3g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33d63fc-94de-4c94-3d7b-08de853696bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 21:37:43.6944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ot0/9DS6DPhlKDTzsXYq8QdEqTM5B3cQsQvOOpBeW6bEQvp7Jn7lYm46P0SpHT8aaj4E/U1e53Fs4P/LcLnQeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6508
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI2LTAzLTE1IGF0IDA2OjU4IC0wNzAwLCBDaGFvIEdhbyB3cm90ZToNCj4gRm9y
IFREWCBtb2R1bGUgdXBkYXRlcywgdXNlcnNwYWNlIG5lZWRzIHRvIHNlbGVjdCBjb21wYXRpYmxl
IHVwZGF0ZQ0KPiB2ZXJzaW9ucyBiYXNlZCBvbiB0aGUgY3VycmVudCBtb2R1bGUgdmVyc2lvbi4g
VGhpcyBkZXNpZ24gZGVsZWdhdGVzDQo+IG1vZHVsZSBzZWxlY3Rpb24gY29tcGxleGl0eSB0byB1
c2Vyc3BhY2UgYmVjYXVzZSBURFggbW9kdWxlIHVwZGF0ZQ0KPiBwb2xpY2llcyBhcmUgY29tcGxl
eCBhbmQgdmVyc2lvbiBzZXJpZXMgYXJlIHBsYXRmb3JtLXNwZWNpZmljLg0KPiANCj4gRm9yIGV4
YW1wbGUsIHRoZSAxLjUueCBzZXJpZXMgaXMgZm9yIGNlcnRhaW4gcGxhdGZvcm0gZ2VuZXJhdGlv
bnMsIHdoaWxlDQo+IHRoZSAyLjAueCBzZXJpZXMgaXMgaW50ZW5kZWQgZm9yIG90aGVycy4gQW5k
IFREWCBtb2R1bGUgMS41LnggbWF5IGJlDQo+IHVwZGF0ZWQgdG8gMS41LnkgYnV0IG5vdCB0byAx
LjUueSsxLg0KPiANCj4gRXhwb3NlIHRoZSBURFggbW9kdWxlIHZlcnNpb24gdG8gdXNlcnNwYWNl
IHZpYSBzeXNmcyB0byBhaWQgbW9kdWxlDQo+IHNlbGVjdGlvbi4gU2luY2UgdGhlIFREWCBmYXV4
IGRldmljZSB3aWxsIGRyaXZlIG1vZHVsZSB1cGRhdGVzLCBleHBvc2UNCj4gdGhlIHZlcnNpb24g
YXMgaXRzIGF0dHJpYnV0ZS4NCj4gDQo+IE9uZSBib251cyBvZiBleHBvc2luZyBURFggbW9kdWxl
IHZlcnNpb24gdmlhIHN5c2ZzIGlzOiBURFggbW9kdWxlDQo+IHZlcnNpb24gaW5mb3JtYXRpb24g
cmVtYWlucyBhdmFpbGFibGUgZXZlbiBhZnRlciBkbWVzZyBsb2dzIGFyZSBjbGVhcmVkLg0KPiAN
Cj4gPT0gQmFja2dyb3VuZCA9PQ0KPiANCj4gVGhlICJmYXV4IGRldmljZSArIGRldmljZSBhdHRy
aWJ1dGUiIGFwcHJvYWNoIGNvbXBhcmVzIHRvIG90aGVyIHVwZGF0ZQ0KPiBtZWNoYW5pc21zIGFz
IGZvbGxvd3M6DQo+IA0KPiAxLiBBTUQgU0VWIGxldmVyYWdlcyBhbiBleGlzdGluZyBQQ0kgZGV2
aWNlIGZvciB0aGUgUFNQIHRvIGV4cG9zZQ0KPiAgICBtZXRhZGF0YS4gVERYIHVzZXMgYSBmYXV4
IGRldmljZSBhcyBpdCBkb2Vzbid0IGhhdmUgUENJIGRldmljZQ0KPiAgICBpbiBpdHMgYXJjaGl0
ZWN0dXJlLg0KPiANCj4gMi4gTWljcm9jb2RlIHVzZXMgcGVyLUNQVSB2aXJ0dWFsIGRldmljZXMg
dG8gcmVwb3J0IG1pY3JvY29kZSByZXZpc2lvbnMNCj4gICAgYmVjYXVzZSBDUFVzIGNhbiBoYXZl
IGRpZmZlcmVudCByZXZpc2lvbnMuIEJ1dCwgdGhlcmUgaXMgb25seSBhDQo+ICAgIHNpbmdsZSBU
RFggbW9kdWxlLCBzbyBleHBvc2luZyB0aGUgVERYIG1vZHVsZSB2ZXJzaW9uIHRocm91Z2ggYSBn
bG9iYWwNCj4gICAgVERYIGZhdXggZGV2aWNlIGlzIGFwcHJvcHJpYXRlDQo+IA0KPiAzLiBBUk0n
cyBDQ0EgaW1wbGVtZW50YXRpb24gaXNuJ3QgaW4tdHJlZSB5ZXQsIGJ1dCB3aWxsIGxpa2VseSBm
b2xsb3cgYQ0KPiAgICBzaW1pbGFyIGZhdXggZGV2aWNlIGFwcHJvYWNoLCB0aG91Z2ggaXQncyB1
bmNsZWFyIHdoZXRoZXIgdGhleSBuZWVkDQo+ICAgIHRvIGV4cG9zZSBmaXJtd2FyZSB2ZXJzaW9u
IGluZm9ybWF0aW9uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEdhbyA8Y2hhby5nYW9AaW50
ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQmluYmluIFd1IDxiaW5iaW4ud3VAbGludXguaW50ZWwu
Y29tPg0KPiBSZXZpZXdlZC1ieTogVG9ueSBMaW5kZ3JlbiA8dG9ueS5saW5kZ3JlbkBsaW51eC5p
bnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBYdSBZaWx1biA8eWlsdW4ueHVAbGludXguaW50ZWwu
Y29tPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA3MzAzNS1idWxn
aW5lc3MtcmVtYXRjaC1iOTJlQGdyZWdraC8gIyBbMV0NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkg
SHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
