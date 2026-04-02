Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8BF32ED24;
	Thu,  2 Apr 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117939; cv=fail; b=mGBEPIzRjLU4tja7i3bZoxXfKk+vAOjgGMooyoRaqmQ+EqdGnCL5fMvbr1PYJAlm5ww+awIiLz3gzho1HgZ00zRcinV2CgZJsIvpUOxnCw65xMGQw/pMzxjN1E8yjLWNuq74BRSN2DSUopSn4zM0zUVfkv3OFfJwU8Z8LhDwx3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117939; c=relaxed/simple;
	bh=AcCWCRMJZP3tHl6t8SXMpNCR4fnXCxU7oxsL8QmtG74=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=etu8z2cWxTie74M8gOIk2sf8uj8gCpy8jBQrK2hTsDSqug8taLLsvcfLg1AkB2S5aEYuinwLChRrTG4hq6Oo0f5SMuTTUmslMbWTnYO72Q+gN8AiwOV6rJ61CJpMhau0WQiQldIn05xEIqwKtBBx9BZ4Jr1s7XGAwxQ5PehVVF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfOTZKSu; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfOTZKSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775117938; x=1806653938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AcCWCRMJZP3tHl6t8SXMpNCR4fnXCxU7oxsL8QmtG74=;
  b=MfOTZKSuiO9I1ydk1ciJjGk7sB7ggEONjR1hRW8IjFXBCJsVBQOX577f
   gvk/sSiRwruOPt4nWal5+izXsy6wQxnV2CW6pEmyGoRFGKcHW+uokIaSw
   M3XRlqBanMBO8Lcvvc2fzA1qjSuKL/vs8rAhzP0AHLf9FV57o6Y6VdK84
   ljiTxS04rE9SIIS1fNeO1gCWNA1UWBzf49xKpT97/USGbv6pvGtCODgVW
   48sx60yIOxbuiPzVcp4ehKXQScbhMB89aaDjcQ7aS+rh8k4uDsjKzE29E
   U2yDOQhQKKy4NExUXOggJfqPgxtQcHOlQudWCXT/Q9w3xdmw/SeTTO3h4
   Q==;
X-CSE-ConnectionGUID: pkzbVCcEStSK+DILwp7NwA==
X-CSE-MsgGUID: YqArrhQURIenbjaNEQ7YYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75345497"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="75345497"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:18:57 -0700
X-CSE-ConnectionGUID: faufRKbFTGqKTlHhO96LaA==
X-CSE-MsgGUID: pns2Y1PKTGGzdoQ/QgbN0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="230980806"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:18:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 01:18:56 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 01:18:56 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 01:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDTc/aiFQu1N01sEKlu5QsrbJKpHWc2ZM1mq+unsC51AL1LQuYP0HD7iRi0q6XjGISqrz+gu9ZqreOp2XBTRW9s5CjvLQUSKqmalopxw+twGbb8OAvyhtscp9An3B9qO9SgAmT0T9BdyjpZlzmjboJc5Qhb0y0Uwzlbl+QS6JY/MoNgfNt1Et1EN83rp1LGv0MgaTqx2IpiKef1uA5Gem5aUhtLf0curHYquSVPu3wu1/FJtbyA1xmIUQH27ag2P69D+8snWUmlpDXo72jVuAuiTmIRIj5ewUftnmVjlTz8YygciEnDzhJbrzLBcibBC0TDkg0Hil5V6efhRcl7txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcCWCRMJZP3tHl6t8SXMpNCR4fnXCxU7oxsL8QmtG74=;
 b=k04cj2JYt8DqVvkmWQY6enXr5teHETLndDhjsW4ZEAetESUBvsFKCbTCGHkDzkBXc1tfP6JhNjazbXu7qC4q3sLBkQhJkOXZG5F7zhQ7QptLcCU2dv0QFMOtxOHKc0ZYWIiSop45X1GKVV+BbzQa1axulwg3kTEtLQldEFBKeVn2SoGiBaLoLnXOOR62FbsXDbFXyRxIc+V4pYDL1NWgDuM6DppmQd49oImlLGAcBTmVGoL3ASHBENsPyVwdN3NAK5Q4XxbBGL4e1Q68d9xZayW0/Rl2Fp9LNJREOitMpPnZGmqEtp3eaI1Yv8ngS3D85JKdVHPmIxCOTXvEkjN03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB9495.namprd11.prod.outlook.com (2603:10b6:208:59f::17)
 by CYXPR11MB8732.namprd11.prod.outlook.com (2603:10b6:930:d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 08:18:50 +0000
Received: from IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::7e17:f6fb:7cf6:aa44]) by IA1PR11MB9495.namprd11.prod.outlook.com
 ([fe80::7e17:f6fb:7cf6:aa44%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 08:18:50 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "prsampat@amd.com" <prsampat@amd.com>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "kas@kernel.org"
	<kas@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"Qiang, Chenyi" <chenyi.qiang@intel.com>, "tglx@kernel.org"
	<tglx@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: RE: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6KLKDJ99GHWikalNKz+1MbbEbW+PPOAgADQbQCAAHLugIABpDmAgAAlqQCABe0qgIADLEIAgAEXMRA=
Date: Thu, 2 Apr 2026 08:18:50 +0000
Message-ID: <IA1PR11MB949557E04741169BA209A69EE751A@IA1PR11MB9495.namprd11.prod.outlook.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
	 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
	 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
	 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
	 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
	 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
	 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
	 <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
 <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
In-Reply-To: <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB9495:EE_|CYXPR11MB8732:EE_
x-ms-office365-filtering-correlation-id: 860cffa8-8932-48e1-9b1b-08de90907895
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: R4ciYT0SDAYq/zXsyHL/FLeZaIQsfsykZlDG5fgAEG8UHPAEudBOHtGKgzSwKjry1PIWX+NQ+FU92V3zU2R1gKDX03cQt1+lMcFbvi2q7xEsitLPdxzoURuw6VyrhwUJdevsGj9ipQyXkz6RtCBta8XF1EWHraB8UBuL2lc/xCOL/68dBOm0mAH+XOzSiRejYUreNDueVK4lhd1xGQtw6FNGjmG90dIh8e5EaXMKllWPpEUtwqWlrJfE7dpe9d9xbuWGRGdvnnBfDyd4w5TiOhaM0ev/26ILhDYb0BJRShYB4gN7ACtPWbIXiG3fXDAV5mepI4RhtTeFwY/+hEcM/C4yqdJuIDyetznwZzz2hR7paMCtBkf+jpVhIf1BU/BfELuOIpKgjQDLuy5G+XudREYvSzhl/t9pF8Unmdhx2ksQVp859QGB2c3hFKO/0rptn6F24rEZ4VtlbYC0hXAAbGw6s2mWxI6wS/+t5R3/XksQP2jJDN3PjuIs5zGyef8MWAXQRTdE/QZqoNsMm21PpEvQyKYyzIfwvDgfscm5aiYPnAkNQWDgJ5PS6q4ho9RgohzJJevrW2+Cu/l0F1dxKNEpxqMFg6chFbluQM+AJtc3MW86Ar/MbPgiIJK52KXbp8EBbp6LGpEO1Sxf6mCSyVFw3bi+V1/UGTJ+f6N97PSERvtRgptKM/fzxyDeYCJ7yiF9DzejYRzLlI441nuAZVzGGFEBbcWmGdbwmYrvWIDGhDyOeqnwuQjj1NgSleaviOuQF79KCErdqvKR+51+a4QE7kFkaL5AxnGlVRf6C+Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB9495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlBJNFM4TG5FMkFYdWZ5NHZuYnV4djR5OGNpbWZGdmkrVThYNEtNWkIxMkFM?=
 =?utf-8?B?dGRuV0ZrWE1VSWIrVlRzb2hWQzRGM1ZHNjh4dWJ5b0ZqRlV1NlgydFRmMEVX?=
 =?utf-8?B?YUN6UERMWFBtaE5scHRHOGtadGtqdVFseHh3VERHU2JkUHB4Sm1Bam4rRTYv?=
 =?utf-8?B?YTNndStMQXFXNzVTRXcrY2V6K0lYMVFYaWpVa1BWcWRUOUxHbXVYRFJ4Qzhp?=
 =?utf-8?B?Qzk2MUk5aDNmaDZqZ2xPQzFJV1JUZlYxS3RaRm9lQnBiWHBtdC9rRmVRTVlt?=
 =?utf-8?B?VG1VampadURhQmVJWjB6RnhBWWg4d1ZIL3JiUk9KOXpQZHg5cUlOWFJpTFQ1?=
 =?utf-8?B?YlkyN2RaSk9lMFVRbGswdUY3UCtxcXJQdjhnN3FWUUQ3NFp4cTloMFpCa2Fx?=
 =?utf-8?B?cmV1TlkzTGJBNFpITFRUSE5nbVAzS0w2NGdWTENMbDJXYnluUWc4S1lIQlNu?=
 =?utf-8?B?MU1JYXJ6ZE8rajVPTGw0MGEyd2pLT1R0M3pJNUk2UXdXc2lwS1A5VDBoQlJa?=
 =?utf-8?B?V3N4QzlEVTM5dlN6cGc5eW41R2RCclIrRzdMNlVWUE5aQWRYaFhranoyYUla?=
 =?utf-8?B?QW5CaWtQWUFaTi9wdmtxQ3ZkZ0NZY093ZUxaTXBZRy9HNStWVXZiMWFsNW9Z?=
 =?utf-8?B?TzZrZFNEOXppdU9YakthcXZzSllISnRUUElQVFZidElndjBwTDh5cnloS1BF?=
 =?utf-8?B?UHVIRWJOZWQ1K1orZG1oYUVoTHpKckE3ZTFSbW9LMzFKUDZFSnJaRTdEemJQ?=
 =?utf-8?B?V0hER2RYTmpodmEraVJIbnd1eEFya1dJZGJMcjlIOWt0MVZCbU5KVXFtVWgv?=
 =?utf-8?B?ZWVYajVxbnJVdStnU3cwNy9heTV1MEJ6RnlJNkZ6Q285Mm5IRDdJZW5DWUZ4?=
 =?utf-8?B?QVF0bytTcFBURHVCcUsybDVrU0VNMk5xS1EvQ09JbWZPVW5hWlhnc2Y1UDNG?=
 =?utf-8?B?bWYweWdZMk95WTU3TElYSWFrNDZJNjh4cVR3azdZbE4ySTEzV2pXUlpQamth?=
 =?utf-8?B?M3ZId1lhZFora2NiRmVCYkZEdTJuZDQvN3RMU2svRjZhNFVUYXFjNDZEM3NP?=
 =?utf-8?B?OUo0OFMvSmVTL0hNUUs0b1hyZGYyaHFKcURiZFIrVm42QmFUekNEYy9NSmdm?=
 =?utf-8?B?TUl4VCtCWEZiekVabXFJeVZkc1E5T0V3VlpFVjBxQ3BWYmt2MUlOVlR3b0Rp?=
 =?utf-8?B?cjRjK244dk1YRHk2VkYzdG9DV3ZjUVp0VXk2aDNqRlh4WnVibHhZckdSZFBQ?=
 =?utf-8?B?VXR4UklabEQ0eXVsc01UQ1BSdmhUeTVodkEvYkZlT2I3NmpOVTl6TmRXWXVp?=
 =?utf-8?B?RUlYWllLaHE2UU9kbTdHTUJFdm8yNVc5U1RDV3VVbW9WZVQwcit5VkM5bnJk?=
 =?utf-8?B?emgwcGhOaUoxVFpGZllubWk3dUFIampvbEhkL2FndEk4eGlhSm44eEt5WkQ4?=
 =?utf-8?B?WHk0RVM5aWdmdFpOSUU3cjhoYnpYTHNnRytvOUxVWnhLYllMdkRGbEw2M0d2?=
 =?utf-8?B?ditGbEFTYlhJYWpPTSt1QWl4VzFZMXF5YXQxVnRuTUdRWDNxdFpDd0M5YmRw?=
 =?utf-8?B?dUswb2w3RjVsaDZ6WW5BeWZ0RVh3YVlON1ZYdlMrRzVFQzNrQXE2OElmWlBZ?=
 =?utf-8?B?VXVBYlhoM2hndGl4d1QvSWlBRzRGQWpsRXRrTUlaREZuWDVoWGI2OXUwWlhm?=
 =?utf-8?B?QWgvYmc3YXlsZ1d4WmtibHlFMUJiY0FsdVA0ejEydzBGdWNMVFdwZ0kwZXAw?=
 =?utf-8?B?Z2ttWDdqZll1U2pBa0hpYloxc3Rqanp4emNpMGlQUlM5ZnBNQVZlem1nTjlx?=
 =?utf-8?B?YzN2WmVLTnMyVFFkakMwVHdMdmMrdWhMWi9EM0RyQnZ4RlpTTTVIb3VJWjJk?=
 =?utf-8?B?NkdVZVJHMlFzc2xYM04zTXUyMTZlZTFPOUprVmxqN1ZoMjlGeTFkSGJneVZ1?=
 =?utf-8?B?eHZJNDRVZ3lFRURGaVhUdklxSmU3Tll3dUZKL0VFR0F2UWJ4SDlReGwyblZ6?=
 =?utf-8?B?SWlNMTJicGRXYldydjFHSUlzcStFSnp4QlpIeTFocW5EcWVBejgwbDhpSGsz?=
 =?utf-8?B?c09lSnpjM1puTVNFU3dLZVRMUFpocXdsdy83bm1PVkRsSFhIbEk5a0tobGhW?=
 =?utf-8?B?UlRUQU96RGdkN1lQOEU3UW8yeXlqV0p5dFZ1WFRoNmpaYmJHM1RBTzNZUmRj?=
 =?utf-8?B?Y29DbHZ4QTFpRStrMjhMOTFWS1c3ZnJFZnBkdG9YWVFKVElrM2psVEs3UWY4?=
 =?utf-8?B?R2RlbWlWY3NnSnpxWUJvbUFHNjU0eEEvMFlFS1ZCMjFyOW1JcGI1T1Z4clAw?=
 =?utf-8?B?c2RyOHBPZHRFVUwwTkdqeVZJNUVadEhIQ2JQNzVtVHp1ODhlNW14Uk5XanR2?=
 =?utf-8?Q?HNAcp+JIo6zwxdM7xgVPilHPPCjuM0N/1uIOsw9txhhmQ?=
x-ms-exchange-antispam-messagedata-1: y6tMGqvcErQnWw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dZ2u7sUscwXMuDulYi6MHfMA/mA7S+y0vr/OvDvDh+gq58wmhj2WiY9UvMYZn5PyIJeFWxwHK4DrYXFt7MOtBn2ZLfdmcyJ0koLQN5DOhrkvOPsQV1pgbSYZ9f3uYyXuC8dAtLEn8T5QFAWWTobbd308zlXoPCAEa+h6jW7KwR0RrgEnaEMzdAcWpKtX7hwQ15oqyWTXkWvc9kuwBB7eTkJXEjZO4td+adTMFaG1orpfPqCOpzavhhgBWalAANT8fCSMr2yc4ISHcmCC+zFNRQvGo8GWXFtzVVC196kHMtAqOElJ4m8ozy6ie5QMf3m+eU/vqjwaxp4noeklf1sSYw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB9495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860cffa8-8932-48e1-9b1b-08de90907895
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 08:18:50.5646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /yp0pb8S8Pgd5BykOEG1uWhFJCdtvLKtNVPDOJ2uEIgUGsFN0cKFrUJzv+7Jh18mhHr/+E6/5ND4DUlj768rOqUtiguGor1ZpFKacy8+5KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8732
X-OriginatorOrg: intel.com

PiBPbiBNb24sIDIwMjYtMDMtMzAgYXQgMTE6MTAgLTA0MDAsIFByYXRpayBSLiBTYW1wYXQgd3Jv
dGU6DQo+ID4gU05QIGxpa2VseSBoYXMgYW4gYW5hbG9nb3VzIGlzc3VlIHRvby4NCj4gPiBGYWls
aW5nIHRvIHN3aXRjaCBzdGF0ZXMgb24gcmVtb3ZlIHdpbGwgY2F1c2UgdGhhdCBSTVAgZW50cnkg
dG8NCj4gPiByZW1haW4gdmFsaWRhdGVkLiBBIG1hbGljaW91cyBoeXBlcnZpc29yIGNvdWxkIHRo
ZW4gcmVtYXAgdGhpcyBHUEEgdG8NCj4gPiBhbm90aGVyIEhQQSB3aGljaCB3b3VsZCBwdXQgdGhp
cyBpbiB0aGUgR3Vlc3QtSW52YWxpZCBzdGF0ZS4gT24gcmUtDQo+ID4gaG90cGx1ZyBpZiB3ZSBp
Z25vcmUgZXJyb3JzIHN1Z2dlc3RlZCBieSBQYXRjaCAxIChpbiBvdXIgY2FzZSB0aGF0J2QNCj4g
PiBiZSBQVkFMSURBVEVfRkFJTF9OT1VQREFURSBlcnJvciBsaWtlbHkpLCB3ZSBjb3VsZCBoYXZl
IHR3byBSTVANCj4gPiBlbnRyaWVzIGZvciB0aGUgc2FtZSBHUEEgYW5kIGJvdGggYmVpbmcgdmFs
aWRhdGVkLiBUaGlzIGlzIGRhbmdlcm91cw0KPiA+IGJlY2F1c2UgaHlwZXJ2aXNvciBjb3VsZCBz
d2FwIHRoZXNlIGF0IHdpbGwuDQo+IA0KPiBPaCwgSSB3YXMganVzdCB3b25kZXJpbmcgaWYgd2Ug
Y291bGQganVzdCB6ZXJvIHRoZSBwYWdlIG9uIGFjY2VwdA0KPiBmYWlsdXJlIGZvciB0aGUgY2Fz
ZSBvZiBhbHJlYWR5IGFjY2VwdGVkLiBIYW5kbGUgdGhlIGlzc3VlIGludGVybmFsbHkNCj4gYW5k
IGFjdHVhbGx5IGdvIGJhY2sgdG8gc29tZXRoaW5nIGxpa2UgcGF0Y2ggMS4gV2lsbCBpdCB3b3Jr
IGZvciBTTlA/DQoNCkkgZG9uJ3Qga25vdyBhYm91dCBTTlAsIGJ1dCBpZiB5b3UgYXJlIHByb3Bv
c2luZyB0byB6ZXJvIHRoZSBwYWdlIG9uDQpkb3VibGUgYWNjZXB0YW5jZSwgdGhpcyBpcyBub3Qg
Z3JlYXQgZnJvbSBzZWN1cml0eSBwb3YuIEl0IGNyZWF0ZXMgYQ0KcHJlZGljdGFibGUgYmVoYXZp
b3VyIHByaW1pdGl2ZSBmb3IgdGhlIGhvc3QgdG8gemVybyBhbnkgZGF0YSBpbnNpZGUNCnRoZSBj
b25maWRlbnRpYWwgZ3Vlc3QgYW5kIGl0IGNhbiBiZSBtaXN1c2VkICh0aGluayBvZiB6ZXJvaW5n
IG91dCBhDQpwYWdlIGNvbnRhaW5pbmcgYSBjcnlwdG9ncmFwaGljIGtleSkuIA0K
