Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE8C42BC54;
	Tue, 14 Jul 2026 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784067723; cv=fail; b=BzoR4xsYYKdkN4ck8/sutN2t9HayTy4NaBoWfAxILUD48kxaKSLFwQ4cnOvhFe/pt8MDLWSOuS3GNyN20pi+Eah4yz/in4vMFN5I42WXEjkitrXJRcEVR1tkUj5xm02uvGFjP0RekDNNdTk6NxpA/1/Ohbp0yGshQt8iS3XZ/nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784067723; c=relaxed/simple;
	bh=dx9Wjc01nqSNB38BrJNYxLFMOd5TdLrFQyc5+NoM1iQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EimMCmdEg0fDyL/K9UVexAnZEk3ASZqTI+YgRFNuQqClyNs19/oreia9UTe6Lx1qyXPzg0g3IY0ddxyiee1KwoXyO3qNCNIt37TvnU70MZi7U6l1pFTcbcRJqutGcHAZ8vrmv/3AMqRZStunGg5EXUoNOQQFjTTC3BbDyE2H0RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMvSvFBj; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMvSvFBj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784067721; x=1815603721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dx9Wjc01nqSNB38BrJNYxLFMOd5TdLrFQyc5+NoM1iQ=;
  b=JMvSvFBjwcUnolnbIFvtON3mtmO+gqe3SLsL+VVhlkOfMhItq05m1/g7
   h2PC3DMyCTWzj4i3zLLiMiyTneb996zihgIHcBZzd3CbwmSI4J283mSVX
   v89sV16YcHcrosJHpAo8f/+3kyU+1vp7srRsWnbDNA+BSL9Peb0i2Pt89
   kidI0625Eq7DnH/j5ET7eJprjPY3elW0aw58vfIhfQBC8x4j2JevROFAn
   xQv+neoPl1nw8XigQIjYVmnrtIWBW2CL/XZnbLLNmCrS1elocJN+3vKzm
   EP+yFKVoU+5ef7OlPEKMwdXiYuUXKY7hZAfhY7YmbIVyT5T3ghpD58+MN
   Q==;
X-CSE-ConnectionGUID: I3HYZPYXSUeTs5uPSIl3uQ==
X-CSE-MsgGUID: J1f8dzP+TbOHTbBccL809w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="95299641"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95299641"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 15:22:01 -0700
X-CSE-ConnectionGUID: zboTR+iTR5qOVcJNYQXWHw==
X-CSE-MsgGUID: gWoxrauJQMqDSVw2T7EZ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="252019910"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 15:22:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 15:22:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 15:22:00 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 15:21:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGOfPxaNLTx98UBcH/RO6ukYqHDklq0MlwSH34QjJL07tNXhQHxUsLzmj9vadAX0wxvT3vbIkSlrkuFxmA3mbFeEZ4mCRVbqcjUdxK8p4kQPIfWA6b9Erc/+ottUSiiGlOdz6swZ8jmikKxcK5bB0hiYiczJzl+y4gnGDrqUwGgf8JKrqvqhwM7PrgU5b+CKPTLVgOJn/KN1zW95JBFdq/V2GYNnG0apBi++Apyalfw0oY0k5oQo0O5Cn3j01jgnwxBGfGI+Ns9YJ5CSKDwBu3ySOEB1eoHruKlQy1I6HSUjR2m4RcQg4EvJ5qXDwQ3HJR2CIoOBfI6/1JSNxN2QpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dx9Wjc01nqSNB38BrJNYxLFMOd5TdLrFQyc5+NoM1iQ=;
 b=eZ6peFe3j2egkLkG3M59WCAvBb3aFH7kYFz/qI980SMMrU5xobVZyJ36KTyMuydFAs/pTnfizI287VZHK1ohp8v/esa5Ef2MxMigaLlQwiTCeZiEZqctiyoGEVRVGKR+s1O0f0s6/W58ke0G8rnEGkT207FXqQRVt9scxzK7HOB6Y1l19GxsYjZVTrjLp2EGpgbY1RBhLPXLmtdI4s7AXO+n+J66+WxE1qsTnJbJbD+XI1STNYBjHjR8isBXn+OcSmZqqq1bvUfTSoGYmENKHdeKsrgItghmqLfkqKG392dAcZ2UzBo+DSpPFNzdJwYmwTk424BoYntzb9ZEwJbzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN0PR11MB5710.namprd11.prod.outlook.com (2603:10b6:408:14a::15)
 by MW6PR11MB8312.namprd11.prod.outlook.com (2603:10b6:303:242::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 22:21:57 +0000
Received: from BN0PR11MB5710.namprd11.prod.outlook.com
 ([fe80::bbfb:d81a:573b:1d5a]) by BN0PR11MB5710.namprd11.prod.outlook.com
 ([fe80::bbfb:d81a:573b:1d5a%6]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 22:21:57 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: Reject nested CAP enablement if nested
 virtualization is disabled
Thread-Topic: [PATCH v2 1/3] KVM: x86: Reject nested CAP enablement if nested
 virtualization is disabled
Thread-Index: AQHdCM+cWIGqxO6+dkexRQML9xUBn7ZsdQMAgAD1SACAAEJugA==
Date: Tue, 14 Jul 2026 22:21:57 +0000
Message-ID: <4b553a78e519e80a33e4362862da70cc9c4711b5.camel@intel.com>
References: <20260630202828.440724-1-seanjc@google.com>
	 <20260630202828.440724-2-seanjc@google.com>
	 <6d8588f8fb1b68fee59d4a0c8cfcfd7a58d25f79.camel@intel.com>
	 <alZ-yMvZb2I2tJOf@google.com>
In-Reply-To: <alZ-yMvZb2I2tJOf@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR11MB5710:EE_|MW6PR11MB8312:EE_
x-ms-office365-filtering-correlation-id: db2834f9-8830-4c24-9afd-08dee1f6511e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|5023799004|4143699003|3023799007|22082099003|18002099003|56012099006|6133799003|38070700021;
x-microsoft-antispam-message-info: w7/QyNNHLuJtUsuXHoh/eO3a3UfYBdC/zAEcLsCcbmA9FTd65Q5mm3oXv9tTDvSgQFmX/QUAg251yf4MBjUYwjJh7Rk7mX19r7NZLP+G0aibhAcl2vmh5P/S5vMagxOq83bTXhIotJKI4glTbh4RBomM70V6fVbxEjs3mnAl8qQ3HhK7olx6xKLiCF1j0zFN5KRmergXoKPEK0o7KuktkZJ//hE13x540M+WAR0NQQZ6wMby8I6r5q4Twmdic2cNWe5tP9xfF2jOStexgoTW6AHK0WHe5nUjypbzlZyDyL/2xXDD+fjfiFB0rYAXo7Cz2CAF6t1EDWXubONA3J+wmbbH96AzoTmU9CK/abfTeXZDDMy89aquSWt5loz3CnCrrVme5xloRh3Bgs+4+k8wN1HsuQu4mA8piSJPyUiLuWAbh9/frNKTDOti8n45tzsyD/02CCqRVF6iGsJdQNH9NMt+LX9BLw+A+Rt19s1Lffz1rj1HW4K4UhDcTfI8rJ4Aurz9rjb0UjmT+m1qOmBVslyUUJA8g4nGpmaDME4HS2y2+VPhSIU8Sh6VEa8yk3YnwND9Fwc6Wy0F6zqj1MeykX/s6OPNthlb+OVVJIHKc1YOSnpoRG/ALCS+FKoCZYsVsuz2ZFKQb8+jIIVHLvMXjMbudmCBgMvCjzppDmHW84BogP5ErgHBtfVFPAt19fkO/DE7RYBT3nvlhHpWhprBpL60H8Y23os4KyU57iCp6+Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5710.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(5023799004)(4143699003)(3023799007)(22082099003)(18002099003)(56012099006)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGlMTDN0N2c1Wm0yVWk3N0p2Sk45UGc0YllIcURqbmNkSWYrbW5zRXc2L2I0?=
 =?utf-8?B?cmYzRytkUGV6OHpaUzU1RldudEhJUGxqVnFOVnl1RlFWMVoxNUFKN0o3TlA4?=
 =?utf-8?B?MUs1RW1BYXppWXFsdWZYdWUzbXdnRDRFN1pzZGlrUEFxZmZoSS9HYkNvL1hJ?=
 =?utf-8?B?Uis1OEpubjN4aXJPL3lRbU9EZjJ6V2Vhb3VXbDhLYTdheHZiZjhXcjRjTU52?=
 =?utf-8?B?bTJkT1M0Lzd4UjZVck9td0N0YjZpK2l5ZERZQlVhbHo5aHJxcDlJWHB4L2k2?=
 =?utf-8?B?R3VzeWRNZ2o3eEdhMDIvYlBFcm9Ib1VYcXdTVHMvZ2pqUnJMaTZXMGJtT1Mw?=
 =?utf-8?B?MWU1R1VrYnNlM2hvTjN3UHRHdHM3UTBGdk5Nb0cycDdZRDBpcmpUUm9ia0pG?=
 =?utf-8?B?RENZOWZFZ0swS3h6U0oweFlvWHZoclJjRnVlYkpaL3o3SDI4Ym9idWUrUlo3?=
 =?utf-8?B?dVdyWUNjOTNTU1hTVVowc2cwV0VuR1FNRHM1N2RWSWhXYlJ4Wkt4N1REeThP?=
 =?utf-8?B?Vnk2bkpEVXVGSi9qSFhndHptRGJUUnJERkdHcXFFdTBBNzZoSmE1RVVwZkxN?=
 =?utf-8?B?WHFqcTB0WFRmVTFDZFpldk9VWk1FbElqRENYNS9NMTJ0aFJ2ck5mSVQ3bVFR?=
 =?utf-8?B?L2pSV2pOdzFXYjVhaXAwT042VnNLcE4veGU5WDNXdWh5YzNPYzZnd3MvT0s0?=
 =?utf-8?B?b2w0K2NWNTNjYXk1TlE3czJ1V1ozdUI2dnpCUHVBcDNOeU1yOFF2UFFtOHNK?=
 =?utf-8?B?eUcyeHc4TWhjODIyaVMyMlZoU2R4Vkx0eDRIOXdFMGVaSEJUcXFJSjFDL0cy?=
 =?utf-8?B?V3ArWGg2MjJCeVZ3UzhqVzVGTnB2OW1CdnJYVDVhYmdaaU9TVVBBa1JOWTBP?=
 =?utf-8?B?WjNza09hUWluZDl0TUwvZ0JzZC83eUd5L2pyQ1VWdDhMNTFuTmhtNEFZUU5w?=
 =?utf-8?B?TEsyZDlMakk2cmpWSml0VS9LWkVqOEYwazNvM2RTeUhTbVJFUzRhRHpCM0NC?=
 =?utf-8?B?dDRVNXJhMTVnb0IyalZURGtzNnRwN1FybHV2RmNxWDJSb0FGV25ENWNNS2JB?=
 =?utf-8?B?aDVBYzdWenVrQUJydjNobGZMVXFmOEw5dUJWV3YrQ2Q0U29KYmJTWWtac0Vt?=
 =?utf-8?B?U0psa1ExUWZNdWNodlhKTEF5eC8wTlJENEtQcmdNaG5LWUJUUlVsNjQ5V29r?=
 =?utf-8?B?VXYwYXNRTnZrK204S0NtTW54UWhib2hEQ1pwbkJPbW9wS3RTajRGcjk2RitB?=
 =?utf-8?B?aEVTd2NzN1VzQkY4VU0rWU5IRlVteC9tOXZaMGttNGpxdjgyWHNLQ2xuNXdX?=
 =?utf-8?B?Qy9ZN3p2dWtSdEdnWW15THRQZzVyclJIT1VyN2w4c1UwNzZkcWVkL0lmaG9y?=
 =?utf-8?B?Mk90Mmt2VERPZTlyb2hFTC92ZTc2MHc3Z1BIYkhWcjFGK0FxcXllVk11elBq?=
 =?utf-8?B?Ty9nZ2dGRVRhTmxRTDZ2eElRQmpySTc0WGp5MU5PWjA2SmNILzhkSzcxRDlI?=
 =?utf-8?B?c0hZcEo5WFpaalBBUk53U2J6WTBSdmtyQjd0eXFVeG1lZlY0MmU4RkgxOEox?=
 =?utf-8?B?UjVkMnVIYVVYQ1g0NVRYcGsvdnFlVGMrMCtoUkRzbzByZHBYNWZoUEpuYUtE?=
 =?utf-8?B?OVFoQzlTWFJsTlFxSDlkWXNSYUNZangrMVZJMU1OVER3Z1plL3Fka1hzWXZv?=
 =?utf-8?B?b3kzSWQ0R2dvbWh0NEtPQWQyeUxVaUFHQUs5cGo5YWNKdVAyWlROUy9sWTVO?=
 =?utf-8?B?ZlNxYmdnMDNMZEM5UTIxbGhYSWlpdnNUbjlsWUcycE1CclJ0NFp4cGpjNUVt?=
 =?utf-8?B?TkErMmcvRmt5b21BYndBRE9ZeUd3OCtKM3RlYjZUSjZuSVMzU0F2VjJ1OTl4?=
 =?utf-8?B?K245alpSNkU5QjFNbEYzS3JvRmNrcGVPK3dKYjZNSFZYaUk0dHl2OFkvTUVU?=
 =?utf-8?B?MVIvT0NqTG84SXBhWEdhb2Z3Zk1SRjVScjNNajZSb0c2SFAzK3hpd2EvQ0Q5?=
 =?utf-8?B?Y2FCRFg2bEdZbDRheWFzNlZ4RXNDMHFQRUREUHRXWFNDYjBtL2FuTm1oUkd6?=
 =?utf-8?B?cU90dDhkbXhBcjh6OWs1ajBabklndW5PUC9iNFd4YWVtbWg0bko4ZHJTajhu?=
 =?utf-8?B?b0FUSUVYTUpTZm1qTlNoQWRLNXlOamQwRy9IRkVlWEszbk1jbTZKcWJmYnMv?=
 =?utf-8?B?VGVENVk3SklTaDV3N3QyNHczTXVEWnMrM25CdDJZalIxaWF3REp4QW9KeE5D?=
 =?utf-8?B?VlZOQjUyVG1pVk5uSEp3YUdhTnRBL2QzYnVRdFBhOHJETksyZVZTT2dPMlpM?=
 =?utf-8?B?bnVidVM4R3Bza21XMWxqaXl2T21mdk0zQ3V4TStEUXZnU1EyMk5mZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C04781D87DCF548AA8F97CDB7CDE038@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HRJuzmkMGUpNSjRnUQJ6NLLxMGkjLjPaSKVw2gE1IdqHLG/zybRzmpYI+FwwYV4iKLWl6Xmzl2feYPQElDd8EGFTNgiIPsNVdzYIZXV87WmuAS7XUGHvoVNyMHxDtv+mIo6uIgvenWEtfNZiZP5Szcwrewh/frc4tZC2gGjY4CabvTmH9fXuE1kjkj9vAf0OyOoYZhrjN9bQ4ON8Lr4uWTIfhoHv2oJmm5TSmkKpEN3K3VfmjUxnKvAGfcqaG1jUMWYqRPzUdDWy5NH346u1S3CzBWL+fQAxsbqMW/YnoFHgWXsk4X78SUEjIoO3lSI7XJvZqqbFA/AeX9Jem/FaBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5710.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2834f9-8830-4c24-9afd-08dee1f6511e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 22:21:57.2072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ihFphuLlBUPqKlxjpVEIXd6cNEYPvQd+Jy31ATqDKcnu3QOxG3Ok7bjQQlm3VHSvWqA+Chixqt/buN2rUyfvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTE0IGF0IDExOjI0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBUdWUsIEp1bCAxNCwgMjAyNiwgS2FpIEh1YW5nIHdyb3RlOg0KPiA+IA0KPiA+
ID4gYnV0IG5vdyBLVk0gaXMgb3Zlci1yZXBvcnRpbmcgc3VwcG9ydCBmb3INCj4gPiA+IEtWTV9D
QVBfTkVTVEVEX1NUQVRFIGFuZCBLVk1fQ0FQX0hZUEVSVl9FTkxJR0hURU5FRF9WTUNTLg0KPiA+
ID4gDQo+ID4gPiANCj4gPiBbLi4uXQ0KPiA+IA0KPiA+ID4gQEAgLTIzNDYsNyArMjM0Niw3IEBA
IGludCBrdm1fdm1faW9jdGxfY2hlY2tfZXh0ZW5zaW9uKHN0cnVjdCBrdm0gKmt2bSwgbG9uZyBl
eHQpDQo+ID4gPiAgCQkJciAmPSB+S1ZNX1gyQVBJQ19FTkFCTEVfU1VQUFJFU1NfRU9JX0JST0FE
Q0FTVDsNCj4gPiA+ICAJCWJyZWFrOw0KPiA+ID4gIAljYXNlIEtWTV9DQVBfTkVTVEVEX1NUQVRF
Og0KPiA+ID4gLQkJciA9IGt2bV94ODZfb3BzLm5lc3RlZF9vcHMtPmdldF9zdGF0ZSA/DQo+ID4g
PiArCQlyID0ga3ZtX3g4Nl9vcHMubmVzdGVkX29wcy0+ZW5hYmxlZCA/DQo+ID4gPiAgCQkJa3Zt
X3g4Nl9vcHMubmVzdGVkX29wcy0+Z2V0X3N0YXRlKE5VTEwsIE5VTEwsIDApIDogMDsNCj4gPiA+
ICAJCWJyZWFrOw0KPiA+IA0KPiA+IFsuLi5dDQo+ID4gDQo+ID4gPiAgI2lmZGVmIENPTkZJR19L
Vk1fSFlQRVJWDQo+ID4gPiBAQCAtMjM1NCw3ICsyMzU0LDggQEAgaW50IGt2bV92bV9pb2N0bF9j
aGVja19leHRlbnNpb24oc3RydWN0IGt2bSAqa3ZtLCBsb25nIGV4dCkNCj4gPiA+ICAJCXIgPSBr
dm1feDg2X29wcy5lbmFibGVfbDJfdGxiX2ZsdXNoICE9IE5VTEw7DQo+ID4gPiAgCQlicmVhazsN
Cj4gPiA+ICAJY2FzZSBLVk1fQ0FQX0hZUEVSVl9FTkxJR0hURU5FRF9WTUNTOg0KPiA+ID4gLQkJ
ciA9IGt2bV94ODZfb3BzLm5lc3RlZF9vcHMtPmVuYWJsZV9ldm1jcyAhPSBOVUxMOw0KPiA+ID4g
KwkJciA9IGt2bV94ODZfb3BzLm5lc3RlZF9vcHMtPmVuYWJsZWQgJiYNCj4gPiA+ICsJCSAgICBr
dm1feDg2X29wcy5uZXN0ZWRfb3BzLT5lbmFibGVfZXZtY3MgIT0gTlVMTDsNCj4gPiA+IA0KPiA+
IA0KPiA+IElNSE8gYW4gYWRkaXRpb25hbCAnZW5hYmxlZCcgc2VlbXMgYSBiaXQgcmVkdW5kYW50
PyAgQW5kIGl0IHNlZW1zIHRoZXJlJ3Mgbm8NCj4gPiBydWxlIHdoZXRoZXIgdGhlIGNvbW1vbiB4
ODYgY29kZSBzaG91bGQgY2hlY2sgaXQgYmVmb3JlIChjaGVja2luZyBhbmQpIG1ha2luZw0KPiA+
IHRoZSBjYWxsIG9yIG5vdC4NCj4gDQo+IEJlY2F1c2UgaW4gbW9zdCBjYXNlcywgdGhlIGhvb2tz
IGFyZSByZWFjaGFibGUgaWYgYW5kIG9ubHkgaWYgbmVzdGVkIHZpcnR1YWxpemF0aW9uDQo+IGlz
IGFjdGl2ZWx5IGJlaW5nIHVzZWQuIMKgDQo+IA0KDQpZZWFoLg0KDQo+IEdlbmVyYWxseSBzcGVh
a2luZywgdGhlIG9ubHkgZmxvd3MgdGhhdCBuZWVkIHRvIGNoZWNrDQo+ICJlbmFibGVkIiBhcmUg
dGhvc2UgdGhhdCBlbnVtZXJhdGUgc3VwcG9ydCB0byB1c2Vyc3BhY2UuDQoNCkkgc2VlLg0KDQo+
IA0KPiA+IEhvdyBhYm91dCBsZXR0aW5nIFZNWC9TVk0gY29kZSB0byBleHBsaWNpdGx5IGNsZWFy
IHRoZSBmdW5jdGlvbiBwb2ludGVyIGluDQo+ID4geHhfaGFyZHdhcmVfc2V0dXAoKT8NCj4gDQo+
IFRoZSBkb3duc2lkZSB0byB0aGF0IGlzIGFwcHJvYWNoIGlzIHRoYXQgYWxsIG5lc3RlZCBvcHMg
d291bGQgYmVjb21lIG9wdGlvbmFsDQo+IGZyb20gdGhlIHBlcnNwZWN0aXZlIG9mIGFyY2gveDg2
L2luY2x1ZGUvYXNtL2t2bS14ODYtbmVzdGVkLW9wcy5oLCBpLmUuIHdlJ2QgbG9zZQ0KPiB0aGUg
c2FuaXR5IGNoZWNrcyBwcm92aWRlZCBieToNCj4gDQo+ICNkZWZpbmUgS1ZNX1g4Nl9ORVNURURf
T1AoZnVuYykgXA0KPiAJV0FSTl9PTigha3ZtX25lc3RlZF9vcHMuZnVuYyk7IF9fS1ZNX1g4Nl9O
RVNURURfT1AoZnVuYykNCg0KUmlnaHQuDQoNCj4gDQo+IFdlIGNvdWxkIHByb2JhYmx5IGNvbWUg
dXAgd2l0aCBhIHdheSB0byBtYWtlIHRoaW5ncyB3b3JrLCBidXQgSSB0aGluayB3ZSdkIGVuZA0K
PiB1cCB3aXRoIHNvbWV0aGluZyBhIGxvdCBsaWtlIHRoZSAiZW5hYmxlZCIgZmxhZy4NCj4gDQo+
ID4gUGVyaGFwcyBhcyBhbiB1bHRpbWF0ZSBnb2FsLCBJIGFtIG5vdCBzdXJlIHdoZXRoZXIgVk1Y
L1NWTSBzaG91bGQgcHJvdmlkZSBhIGFsbC0NCj4gPiBOVUxMIHZlcnNpb24gb2Yga3ZtX3g4Nl9u
ZXN0ZWRfb3BzIGFuZCB0aGUga3ZtX25lc3RlZF9vcHNfdXBkYXRlKCkgc2hvdWxkIHRyZWF0DQo+
ID4gYWxsIGFzIGVpdGhlciBPUFRJT05BTCBvciBPUFRJT05BTF9SRVQwLiAgVGhlcmUgd2lsbCBi
ZSBzdGlsbCBjYWxsIHNpdGVzIHdoaWNoDQo+ID4gbmVlZHMgdG8gY2hlY2sgdGhlIHBvaW50ZXIg
aXMgTlVMTCBvciBub3QgYW5kIHJldHVybiAtRVhYWCBidXQgSSBndWVzcyB3ZSBjYW4NCj4gPiBs
aXZlIHdpdGggdGhhdCAoa3ZtX3g4Nl9vcHMgaXMgc2ltaWxhciB0b28gYW55d2F5KSA/DQo+IA0K
PiBJJ20gY29uY2VybmVkIHRoaXMgd291bGQgYWN0dWFsbHkgYmUgbGVzcyByb2J1c3QsIGR1ZSB0
byBzdGF0aWMgY2FsbHMgYmVpbmcgbm9wcw0KPiBieSBkZWZhdWx0LiAgSWYgS1ZNIHNjcmV3cyB1
cCBhbmQgaW52b2tlcyBhICJtYW5kYXRvcnkiIG5lc3RlZCBvcCB0aGF0IGhhcyBiZWVuDQo+IG51
bGxpZmllZCwgZXhhY3RseSB3aGF0IHdpbGwgaGFwcGVuIGlzIGhhcmRlciB0byBwcmVkaWN0LCBl
LmcuIGt2bV90cmFuc2xhdGVfZ3BhKCkNCj4gd291bGQgcHJvYmFibHkgcmV0dXJuIHN0YWNrIGdh
cmJhZ2U/DQoNCk9oIG9rLiAgU28gSSBndWVzcyB3aGVuIG5lc3RlZCBpcyB0cnVseSBlbmFibGVk
LCB5b3Ugb25seSB3YW50IHRvIHVzZSBPUFRJT05BTA0Kd2hlbiBpdCBpcyB0cnVseSBvcHRpb25h
bCwgc28gdGhhdCB0aGUgS1ZNX1g4Nl9ORVNURURfT1AoKSBjYW4gY2F0Y2ggaWYgYSBOVUxMDQpw
b2ludGVyIGlzIHByb3ZpZGVkIGJ5IHZlbmRvciBjb2RlLg0KDQo+IA0KPiBBbnkgc3VjaCBidWcg
aXMgaGlnaGx5IHVubGlrZWx5IHRvIG9jY3VyLCBidXQgSSBkb24ndCB3YW50IHRvIHNhY3JpZmlj
ZQ0KPiBkZWZlbnNlLWluLWRlcHRoIHdpdGhvdXQgYSBjbGVhciBiZW5lZml0LCBhbmQgSU1PIGF2
b2lkaW5nIHRoZSAiZW5hYmxlZCIgZmxhZw0KPiB3b3VsZG4ndCBwcm92aWRlIG11Y2ggYmVuZWZp
dCBpbiBwcmFjdGljZS4NCg0KT0sgYWdyZWVkLiAgWWVhaCBiZWluZyBhYmxlIHRvIGNhdGNoIGJ1
ZyBpcyBtb3JlIGltcG9ydGFudCA6LSkNCg0KSSB0aG91Z2h0IGFib3V0IGluIGNhc2Ugb2YgbmVz
dGVkPWZhbHNlLCBhbmQgZm9yIHRoZSBjYWxsYmFja3MgdGhhdCBjYW4gb25seSBiZQ0KY2FsbGVk
IHdoZW4gbmVzdGVkPXRydWUsIHdlIGNhbiByZXBsYWNlIHRoZSBOVUxMIHBvaW50ZXIgd2l0aCBz
b21lIHN0dWIgZnVuY3Rpb24NCndoaWNoIGRvZXMgV0FSTl9PTl9PTkNFKCkgZmlyc3QgYnV0IG1h
eWJlIHRoYXQgaXMgbm90IHdvcnRoIGRvaW5nLg0KDQpUaGFua3MgZm9yIGV4cGxhbmF0aW9uLg0K
DQo=
