Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6D438463;
	Tue,  7 Jul 2026 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445125; cv=fail; b=NwJDWTXQzUo3ZQWmxrdUK49eMIvHjNJ0qOSGWUUOuXRQwWfpi9enZ/Zk2fyU7NM0rhJxUx/31SzPQ9f6JGptPjL8K010/SKa99H5Iq0hoho/l/zP1VO3ddPLio0z3fvmW1yd0DHrYp+H6Rk90Z9VmCRSqyVZsSr3dbp3CQH6xmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445125; c=relaxed/simple;
	bh=7Asamc249mIB08uXQSc2Vrh0fT9CCl1bAWBr18EHqps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nQ6pUiAN7xSqoq/urTRwTNJUkgapTCtBzycddvnyShcpOy7h8AKFqoq6qTIGpvjqrO1V8PoXy6Az3wkMZqjoCDmakRt/vIhUK4xFPEywyOK1q0ZtjzZAdkp6w/pGXXtmldHB8Ya3wlhcpR4nh60rUg1hgKVHF55BxXvKjzVFxEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwBFlRpe; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwBFlRpe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783445123; x=1814981123;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7Asamc249mIB08uXQSc2Vrh0fT9CCl1bAWBr18EHqps=;
  b=gwBFlRpeGD/FW3muHDGsghfD4ZJEWgg+YnECBpjslkM6rEAtZ2RcFhxA
   NtGkx3bSKZ5LeAlGtZwf9i2MOSvfhPRH4eLapqK1ufEyIBCI/F/ytu9vX
   ur5cV6sHtkZWm2lXBwpm04H2EKq5/HrmyTlM/vy9N9KzzwLn9pnwFHAUe
   mHyWMo58dVzJ02MmYFrEk3C58FH7lvF3ctEx3l4KKgbgs52maaH+CRklr
   JaJ0Dt+OsIS8A1JQyam/ELS8Rxza9JhBwOfxtVD/Kv8iOXpmji9y5y8gr
   WUeqmtgUYV+VNo3iWFlW5BDwLoaklhzBpHaSA/Qc9NmCO0H5NIfcw6UY8
   Q==;
X-CSE-ConnectionGUID: UYZl+IvdQIynEV/jmmmC6w==
X-CSE-MsgGUID: gQVvw7fvShutnoUQxaN1+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="87918088"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="87918088"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 10:25:23 -0700
X-CSE-ConnectionGUID: dSFXiOFfSNSZPlh0PIADdQ==
X-CSE-MsgGUID: KaC5haepT9ifKzDYIrf1cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="257936751"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 10:25:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 10:25:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 10:25:22 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 10:25:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBxyuCBTbLVNFQTnr4JLaQwTznZTJ5yfnRIgsSR36DXPEz5A4iMLEfcCbmYrURdajMulhpNR8hQIZnM64OwXSRP+HtjVQK1TOILBA8pij+9CqlxPo9krSa43E4M5uyfJR346z2UHLEV8lVQvezqEqAlihHX7k3bdy29QR41Fx/rwjYh9oGlGNFkCUdWdHlCMZ19dlf1Eeo6qPL+cNKPvBI5E4MsEvvdhvXNRCRuoJP1squ+28DrzKpJ7dwuKkSTdzu7oZmQ7G2IBEYFWgBhDgqE8AG4s3gG6+5OKTU0P7Z7ryp6qzggZrd1nsVlbeEevMvQXPV/VJ4FN7TjbW8pUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Asamc249mIB08uXQSc2Vrh0fT9CCl1bAWBr18EHqps=;
 b=FszkKbxEpzkW8lTCC/2zuOPhT/Z13iECcy960xwH0ek6LPp4qfPYOeExAOWJlRzwdFgPEPrwAOiy040daQVe/XnctU5V3r42PlxiSeThbqHZpYuuFZQ3FHiL48m8TO5VG9pdIR3T2qq/VS8eTjPo71EbdJ9CD7jXNmo6y+VFEc4Dzqx2JekgztnvPdBUZ6NFg3VvRqflJpzeDzuUwTRXh4f+fUOzUr/i8iatbkIuU+EQvpw/E+cBVEnDPapcTwM/KDnZoYYa6w21ftKHaZhmGm8PIIPkUiFEaTRk/Fo8BaeC/W/LYWV9R6O2NFbe+I+cbhIONDokn/6IzX7mambgfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by SN7PR11MB6727.namprd11.prod.outlook.com (2603:10b6:806:265::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 17:25:17 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 17:25:17 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Huang, Kai" <kai.huang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "Annapurve, Vishal"
	<vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, "Gao, Chao"
	<chao.gao@intel.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v6 00/11] Dynamic PAMT
Thread-Topic: [PATCH v6 00/11] Dynamic PAMT
Thread-Index: AQHc7Lharxh55RbAGkSefZRzihMYJbZhO7eAgAFDE4CAABLpAA==
Date: Tue, 7 Jul 2026 17:25:17 +0000
Message-ID: <afa3018f954a08ea2bdd44782026e94b74be646a.camel@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
	 <f2b2a3a048ad6429305e0e21319a8c27bedf39db.camel@intel.com>
	 <ak0mnZKoxK5Y04Dw@google.com>
In-Reply-To: <ak0mnZKoxK5Y04Dw@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|SN7PR11MB6727:EE_
x-ms-office365-filtering-correlation-id: b0cbddd0-0446-43a9-8cbb-08dedc4cb6a0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|7416014|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: od96/80d8C0jbuigPdr7crmkNFTkBzyBh9sD1i/vqBHKuSK5w5xHU5nQSPZn2n5Vo2dXdN1ZCuvRtnQuuKobPFbgOyFNsgtUnD2o4C/f5u53odzMjorVDZ+3LV7wcZUXGzz4OsXujedviaTnbf5aL1nbBJn5rMTkq1N7xrA1ot2xUN0QXGsfOuzV9c5GV3lO7lpbF4DBCVQ01t2zXoNybcXQFZGYUtjT1i1EaRez8y0at8LMTiyt8PRINh3UB5a4bqogZNe7KvSOBnWCXB+trSbX3UQCeVTYkZ/yaeZg3Wc7AcAGluxn8LG9Gei2u9Td9WEakNNEiHb/d7WkDS3kEVLbK4WflFjKKIXQRc1wrrh0T67VKMwDHEKr77n8q7NUspeKTFChK8asQUu3RyzRTJsYrEwBTc00zDC8lYSgToEbzR3pHhLtW2bzT3f09MO1xkG0L+6rLQ2MWmct2IVGYNBLfMKUEZIQvTiNvr4uSPsLsVQt8nUcSBqnJMj4eyKpt0gALou9t5sja57qtoDM4Sk37hhnEP+31ZyTgxSJ4MIYZv1shTs8NGsy+uFC+taFv41/OupaOnfSAa8jgOJY+DGmRMFITGkn0d6KhlX78mKOZH4YkoB0bcuqRk7ouw7KPAesmM0xnk+R1YHs3uywqBqtSDPAMPeSvbZTxrfmriWN2O7RK9hvPtrkpC7k7BEV9eGUZ0cvpeaWUOJk8feFMRLwspdAHYUUFaxwV7BFXpo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(7416014)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW13bmFnZU9PN0cvRVArZUwrdUxJRG5ueGJSSnY5U0xMWVVnaDBBNTMyOFpx?=
 =?utf-8?B?eUZpVGNTdVBsNjMzRG5FYVNjTWlPOWNVMnhhMWl1dnZlSGRScHNLK0dpK09I?=
 =?utf-8?B?UitaVWdHa1FSWGFOVk5seWY2bmYxMGpMVE9iNXBkSFl4czlJQ2ZRRUNtQmxB?=
 =?utf-8?B?ZUM3VXRaM2lucHJJS2ExY3ZsblJ5WjhIVHJPZ3ZaODAzKy9xTFc0MG9yN3px?=
 =?utf-8?B?QStNQWtnVnZSTWdEbjNXcVRieEVJVHptVW1vRlVaK0tvTlB1alB0V0N0cndt?=
 =?utf-8?B?c3JrZThSVkVNVzgzb0ZCbnB0RTlDL05JMWlZcUxIUzIzM2YwemJLWndpMmpM?=
 =?utf-8?B?VTF0VXJudERIcDlwNmxMTW9NLzBlNlRWakNFaFVBL0pXbWdNMk5NUnNnZ3F3?=
 =?utf-8?B?VXlaUVFIZkhaWTViaThXS1FEYzkvbE5UN2dSQTZsdEdxTkxtdTdoOGFVNTdQ?=
 =?utf-8?B?aEZDc25RcERyZmw5Qnc1Y0FkWmswUlFEUTlPNWNWRjZaVGJXb0NuVVJ1Rkk5?=
 =?utf-8?B?MVFJc0x4OGY1cU9WaTY2YUI4bUVMMy9lRWYzY0ZvZWtEMkJHdEhmcVBKaHYz?=
 =?utf-8?B?Y0N6TExya3pRMTFrNWlOc2NQYWowYnZveVF3S1hoNitKeG1NM1NPaVJHMG9n?=
 =?utf-8?B?ZUVnVXgyMXZ2NE1vL1lVTmxyaDdEUGgxM2h1NndZb3dMTXZmMkN0STRiQkRq?=
 =?utf-8?B?VGJrbE85dEtDZTFzNzRuQitLcTBQeCtzc0w0c0QwbDNOMWpVUG5xcmZjeDho?=
 =?utf-8?B?d0pJYkF2eGhWRmowb3FSYzBybDJzeEZ4RktDZGFOZjlPZmVQSjN4aE1rcXhu?=
 =?utf-8?B?Q0lRRmZXalp0ekN5NE5HazR1dC9ZczVHd293SGkvaFpIWUhEYjRrdHI0MG9Y?=
 =?utf-8?B?TWZSUGZwbkwzUHcxaGh1M1BaNHNFbVREUmVicGFjR3FtRlM1SmlkcjBoV0dW?=
 =?utf-8?B?RGo4OFlXczdqbThYRy91RmVRNFhEMkpoWlJ5VXBUUTNGOW1ML3lOZzVGU3ds?=
 =?utf-8?B?cFRLUi9tSnlLckZoRWNsUFNMeGFtQjFvcDJaNVY2VHA3ekFKTFA4RURnNE9U?=
 =?utf-8?B?R1ZnaE95TzYwblB4bXNDMFRmc3JuclpWRzlyRmdrTDNUb2dPU0Zxdk1jMDZY?=
 =?utf-8?B?c05ybGpVc3FNblMybC8vZ0xKbGlRbGtRb09xOGRlcXFoREh1SEhSNUNqa0xp?=
 =?utf-8?B?bStFRVZobzlLSk9yaWNySUI3L1BObzBGbUQrcGJmdnlqaTlXc2J5a29PWDdu?=
 =?utf-8?B?K1RkSFFIaVZ0d2FOeVdJTEhJc01XOHlZMDdBTWFJNFArTVhYbDBYbVk1WFdh?=
 =?utf-8?B?OGw5K1hzOXRBUXRsYzAyenJlYnh1M0ZmKzFMdkRQZUVFTWltVDRTeGZMQzZQ?=
 =?utf-8?B?VjJENDZreHZSZWc5MXVnaWJCbTNoT2RkakRUdkpEK3VPdzJLdWljQVpkamFR?=
 =?utf-8?B?UzBoN2tVRDRYNmx5QjV2cU1xSXV5OGdYR2dCdTd2MkV3WjdPcFJTOEI2alZK?=
 =?utf-8?B?cGNoc2dHL0dXTFVrVjdlcFJPUkd3Z1QyYmFoSGNRcXJOdE9uL2szNTRtNGo5?=
 =?utf-8?B?b0cwbWtTSmVEdExYdnBGVWJoVXdKajdGWUphU3ozNFZjS1p2Nk9yeStJU2RF?=
 =?utf-8?B?RkpRUkpMOTd1cy96QzJsemdNZGc0Tk1ldkxGcFgwLzNNN3pVRmZhRVhpdE9G?=
 =?utf-8?B?SFVXdlorSEZsN0RCWDdkdDFKK3lqT1FxOFNyRFlRZGNuVXRIaFQzazZINzh6?=
 =?utf-8?B?MUVIUk5XK0M3aFZYcExFQlhMY2c1TThLaXhLQU1sZk0rYXpFZjUrVjUwNGpU?=
 =?utf-8?B?V3hlVFVsY2hkaGVReHE4RXlJbXRUTDhReTJqUER5dEJBVzVDNXlqalI3RVdH?=
 =?utf-8?B?U1dBZHowRzlSMHo2VTRvdFo4Z3NjZWhMOHprazc2V2doNXJoTWZySm1TMVBM?=
 =?utf-8?B?V3NqTWxJR0xlMEhwV3Frb3VUS1kybzIwT3JpSjBtNFZkUWUyTnhwUE5qYWtX?=
 =?utf-8?B?UnVFMVhaQ2JiLzZNTWowYS9Za1JXelc0TlZYOERsM3Vkd0cvY253T0k0UzlQ?=
 =?utf-8?B?andaSnpoNTZkUjM4ckR1K3NQNjRJakhjM1JCaEJwc3U0SHNpNEM4OGhFanZI?=
 =?utf-8?B?cVFTMnlPa0NLUlEzaFZubnExeDcyMExOZHhtZjVHK0lURUZPTXVQbGRnR3dS?=
 =?utf-8?B?ZDU1SG9nbDdaZTRRb01aUStUbTZWOThJZE9KL1JuY1R3anU4RzArWmVnd053?=
 =?utf-8?B?V3ZIaEpWbnFPejRSRzRqNlpub1J2MlBrT2hueUthcW9WTUFvb0Ivc3l6eU13?=
 =?utf-8?B?ZjUwMUg4Y1YwQUUrV0s0TmlUTGtSZDFGV3JBRnBUakNDWm9RRHBhdDE3c2xR?=
 =?utf-8?Q?+HGcqalJCNM+isoU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D72CA45156C17043B495C3B2C5396607@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VSzvXBFNmqwWuCuKY7aWuPEb/UK/1snl6Z4iPJcPxqMJseccn2juwc3JOv8eJGT/nk+Qnf8o5awrqJhFlXvJOJyVwD4SoD4qe5HMHVCpUoqG28NKJkY9e2Is/WVHqehoxAdk30RLWrtI3da+bIBznbIps2YEFk8EqEtXCra/xA4SVnrAb3f7OrQQXsTk4nMZsU9+xz1f3jkEsnFG1VbRrKR+uhLMPYmtGPLQnxJWt/dTOTAwyTXr7zWd9Dr6+rN18P3Rn0bXAGhZvavfBXS1IiJhzuWtxuGBfhKH2LgB4u1tkEy1bbhshGiWKegt8q8TaPipYL6w0f6JyOysRh3cjQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cbddd0-0446-43a9-8cbb-08dedc4cb6a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 17:25:17.2501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIXuHrUkMQZmN7w9Y3TEN9/kqrE0GfcRZdh9v4Yc9n862z1m+fjlIRKPXmD5r4oe/D28daMX4Zmq11coy8Mmk1ws9JoYnpxhgGX6NFzDTbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6727
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDA5OjE3IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBPbiBNb24sIEp1bCAwNiwgMjAyNiwgUmljayBQIEVkZ2Vjb21iZSB3cm90ZToNCj4g
PiBTZWFuLA0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyNi0wNS0yNSBhdCAxOTozNSAtMDcwMCwgUmlj
ayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gPiDCoCBLVk06IFREWDogQWxsb2NhdGUgUEFNVCBtZW1v
cnkgZm9yIFREIGFuZCB2Q1BVIGNvbnRyb2wgc3RydWN0dXJlcw0KPiA+ID4gwqAgS1ZNOiBURFg6
IEdldC9wdXQgUEFNVCBwYWdlcyB3aGVuICh1biltYXBwaW5nIHByaXZhdGUgbWVtb3J5DQo+ID4g
DQo+ID4gV291bGQgeW91IGJlIHdpbGxpbmcgdG8gdGFrZSBhIGxvb2sgYXQgdGhlc2UgdHdvIHBh
dGNoZXMgdGhhdCBuZWVkIGFjaydzIGZyb20NCj4gPiB0aGUgS1ZNIHNpZGU/IEknbSBob3Bpbmcg
dG8gbWFrZSB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoaXMgdGhlIGxhc3Qgb25lLiBTbyBpdA0KPiA+
IHdvdWxkIGJlIGdyZWF0IHRvIGdldCBhbnkgcmVtYWluaW5nIGNvbW1lbnRzIGJlZm9yZSB0aGVu
Lg0KPiANCj4gTEdUTSBiZXlvbmQgdGhlIHRvX3RkeCgpIGFuZCBBc3NpdGVkLWJ5IG5pdHMuDQoN
ClRoYW5rcyBTZWFuIQ0K
