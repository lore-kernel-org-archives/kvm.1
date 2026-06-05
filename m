Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722983C0A1A;
	Fri,  5 Jun 2026 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645562; cv=fail; b=EqUgPraXaJQvKvMHEC24M2FUie4T//7oNctbxEtMZy4zWlwfzZ252OE+coy5fL/hCHi7UF6BgkDuoFmjNMT3Q4E4eFg3xveUdo1mcuxpHA0abPoKsWbpjNxRrXwtVpXNCYW+UaIjDdXVyprMP9wLPzsSeMR5wkP/p7EQleZkQVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645562; c=relaxed/simple;
	bh=7+/QcDgORaAa+QK5xU2G4wt87wfdl8VLvJHuagantbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uCWKNMUikaRej3J7mx8aiGM60csozOJqQfGh+kkRORNfZjYmTcGVcRd6ybVy54E+Y5jmARJa/JzDyJbDBAzVXgOonXbewndfkvsMn2//ytc1GDZsR5lgsVfBzk4w0i8YzlGSbv0iYXIg/DN/pP9XO5FYRze1Dn+EQ0gDOq8VHXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ny4NuTkY; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ny4NuTkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780645561; x=1812181561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7+/QcDgORaAa+QK5xU2G4wt87wfdl8VLvJHuagantbw=;
  b=Ny4NuTkYJ2PnRGxOeTVkyE9wGHbaQpGevPSzDrKuwmfv2e7TneI/1fE4
   WDwx7Q2KnQSFQT0+ZImg4PPtH4EqgNtvBtykenCXb3Q1QmkR1svxS7P/K
   TCjEuTFwAmKnSGIJCqSm75B5vzDFJ19abksVoEPqQ1S1sS2IwUtkJ2d/E
   jdAO2Ux597SwuMN6384BEQh5OvUjxtTY+3+1ECvSVmG0Jt+QkRJjnCWI6
   sPO8micCV6Odi9BGQwwxLHZ2jYQYYdRVsdTNN/0Jh6DiP89zp0fLP00GZ
   IDjeZWb9IUdjpAasJluhKXag8g5phXby4GWxFhbVqcEmK6GqS8C38LkEa
   Q==;
X-CSE-ConnectionGUID: T2AzKWZIT+C5biohdnU48Q==
X-CSE-MsgGUID: NO9H139nSdS8Lo3j/sgakg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="69012859"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="69012859"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:46:00 -0700
X-CSE-ConnectionGUID: xBiHEMsARuaQPBGhHh0Viw==
X-CSE-MsgGUID: dyLKIq0cTq6aZ4hSbjTVKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="249707727"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:46:00 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:45:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 00:45:58 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 00:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/D5YPrXSkcgG8GfiDp1FgA5qvABUjUObRMK/N4ImKDImC3d0IWg+inQbgOgaTCYe9Eo/NbhPR7kE3L3UMISwm794pzraeHPOqJFfP7tYy1aL8eD4Jp7GBZ7+IFi8iNyRdjiUYM78EFYPEEEGFiJXNIf3IvkqMddTaLfaD1YUVLLx9cCdIlSbFaOYIMrey0K1EOKF/Tk1fV2nb+mtxDPq/M3f4mV0Vb9vqcTu6cKcxYKXkmXNn/XYlPrzxQiQuAO+De3gNtee3fBLBBCt/+F3jLSsgQeRXRZundt6PO+ocY2jONlFPAfYfoahNnJRT3v0kPu1gPJNuoDTnPZOwJv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+/QcDgORaAa+QK5xU2G4wt87wfdl8VLvJHuagantbw=;
 b=k6so6w27CzguiY9Xmo8RObE5Mr0VQV7gxZ6ljwtys9mZPZOZGzodi5ZDqrrVN1UtHeAbz0IXjr+OPUMClj8wXTqGFRTz3m+zqwQQUCLSrRxGpGVY0OYQ31bfoySVHsgEhTQYSvHXZXH4dECfVnMPv3oyUwU2hAxs0KSxXDi7NCHfFKveD+1DNSZ3linuVo3FAsi8JmkiAy9uGpbwiTBBslaTnVVjKtUtXAEBblp0o2a/2Zp2Y11eKXqFvj/ODRB13Kmw15SIaVk+tgr/m03UIOQJ9uS8iM4SciPeq9qiBPnNRYw0tkZNS+873933FfK+SxhHGrp2jOlL6031RIhbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 DS0PR11MB7766.namprd11.prod.outlook.com (2603:10b6:8:138::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Fri, 5 Jun 2026 07:45:56 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 07:45:56 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 34/40] KVM: x86: Move misc "VALID MASK" defines from
 kvm_host.h => x86.c
Thread-Topic: [PATCH v3 34/40] KVM: x86: Move misc "VALID MASK" defines from
 kvm_host.h => x86.c
Thread-Index: AQHc77nMIfChLQNqwka5iBSflv7287YvnzkA
Date: Fri, 5 Jun 2026 07:45:56 +0000
Message-ID: <0dbe94ba88bc2c9de04233cb72964fec762e228e.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-35-seanjc@google.com>
In-Reply-To: <20260529222223.870923-35-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|DS0PR11MB7766:EE_
x-ms-office365-filtering-correlation-id: cff2f755-2391-4d5c-b4e5-08dec2d67a44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099006|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: J8Xsgs0AK0Rmcx0XULShOdVdGEULT437mv/sok1pfa87Lg0052b/DZVkGNVVjmO+Sv6zE+X8zZCdSJsAocblGm3re7zeBoZw0DqzL9B4wSpfnWAb5OAmRrswbkJxvbhxl2BMYL+8Z95Q/L2JMm2QVCjYmGgru/E/LFhtPWU9WXpP8JTEdJEWRBEnQ9l1n4k2Hek9gKCvvP3Z3pJRs0Ux4w8BdOaRF9gYgsm3v0nnRD/GHYbk+AgzdIy2dUSly9XQeYhrHmTM8ADGGBzyAjMVcamxbtYbkAVmwAl0k9fU4c4dNnCo829qVSbv4PRdTLf3tRNrFsfMBIUiYwLQt66+sgPmBzF8Cm844hDYvl4GS4+n0lgK6uIApYtRPzKIhTubxUNQWUJD278NK53mGIj0DagUrEbUqzcJHkbskz2nvRyU3r12faDRlZUGjtKZkibhUNebQmeGM4+Dq/OZmen+im/INCv3I4/7AkCgCut9v0p++WhBe1tqa6Cdpd4UlKwWMJzZz4ymX05FSmyl79YhxXubg4JYUlgGowUaM2cDGgRjk66dPvfr/cR31I9gpbFG/UCNFciqgA8EElMfmESxFtjD5A/oB7jNV+23m0gqYewvVYQlhmapNYS7S05XZzAt7G1xE6l8Wipi+XpUvrgfYjLfh58iVdQPUkgc7JEoemTbfJCmETfUKvDtKIezkzUdQorY4YPhJaXy6ue2lyTJuf7336QVtsumSBZeyZhRL5Z+slwiXtax0amVDyNguHx3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTg2b3ZYTXcyOGQyeURweXBMUE5NbDdQT1M5R01xM25FRzBJUXh5dGFvcWZP?=
 =?utf-8?B?RnFKY1dscWRIc0k2VTdQWjNFNjdPbGhhNlBwNkxnMTROUFpVSHU1YjBLaFNM?=
 =?utf-8?B?UFFucmVONytTK0RoVlV4WXR2REEza0svK1NpWndtWC9RWE9YRHpHL3lEVzFl?=
 =?utf-8?B?Ymo0SnZZU1Y3a29nZSs3TGlZaHdKR1I1UURqblYyZVlPd3NxWFgvYTZ2K1E0?=
 =?utf-8?B?S3BLRlVuWkVDaWJ3dit0QUU1d3VrL2xlQm5IdWNUdE5BcC9UcFVnSndWOEVi?=
 =?utf-8?B?SldHM1dFVGdPSERGd2F2ZE1WSUZkZzZCUXRIdmJHNXZSTVc3YmppRFJHcUVB?=
 =?utf-8?B?V0huTTM5bzVEd2RydHo3VmVEKzRzLzJBNm9SSGhWZjdqa3g2YUFpQWd4U2VX?=
 =?utf-8?B?L2R3MlQ5c1ZodXZkNEoxbE1Zc3Arb0Q0bHU4RjJsVnM1b1YvQmJVR2dHTTVo?=
 =?utf-8?B?YmdzRndUbEI2d1JKcncyalZUMXpiWU5HRlhzWVZQU3JxVDBwK3pwbnhhTVAz?=
 =?utf-8?B?T1JNMEVLQVVndXphYzhkajltVVpkODd0K2lBKzRjS3pxdU96Y2NIVnNaOTNn?=
 =?utf-8?B?VUp2eFp0eUs0L1NnRW1pQUZ5VXhoOU10QzBIaVRyQ2ZoMWZaTEVac245VVFC?=
 =?utf-8?B?R0N0am9YeGZlcWdsWUdOMlVsd0R0RmxhUjcyTm1NZk9ia3l3UDVxRkxVa1A3?=
 =?utf-8?B?d1BhSDRRWGc4cFJSTzN4K281ME9ndzN1VHNDTVNESkVyYU12TlRYb3lUZm9U?=
 =?utf-8?B?SjNIQmgvcUNjUmU3Vm1HMDRHajdxV2dTT2dkQmx0cytublNXbnl1YnhRTGZF?=
 =?utf-8?B?RkpTcVFZMjFNMU1iMFozQmRUcFlhUzZwcGFpOWFlYlJEZmQyYk55SzltV0Zq?=
 =?utf-8?B?R2MvYk8rMzhlQlg0UnFTZnVxQlhiSis1d3hSZmF1blI1ZmI1Z1pVQXl6a3Ex?=
 =?utf-8?B?aExFUWhVR3Vyd0pCMXU1Q2p4eFQ3NlRlSXJ2ZitHU3c3V3hjYkd1UHlSUWZN?=
 =?utf-8?B?V05kTFFmblIrWndYeEV2QmVxRE9WUzNIU3N6Y2F6NXZ4U2o5TkdBWExJYXNo?=
 =?utf-8?B?MWYwaWdWWUFrdFlZbCtBK0tsbWU2WWlwTVRoQzFZYzhEM2V2OVIyVTNmdnJJ?=
 =?utf-8?B?YnIrOGFGRjZNV04zaUtmamEwaXlVVlNOV3Ftck1oTTM3S3RmMU96dHQ1OU1K?=
 =?utf-8?B?LzFaZ1ZXOXFrVk9acE9Ec21ybGFjZG5qeGhEMVRXeHlBL1duZ21jbHhPL3FD?=
 =?utf-8?B?T0VXdngvb0c3VWJINVpvZ2Z2bCtSWHdEMFFZaDRScmZPWmNnVkFhWm92SHc2?=
 =?utf-8?B?Q3JCUzBDd28vN0JHNzlVSHVTVVRKSnRwWEYwbmwyRisveW9WZGRjaVFDaE81?=
 =?utf-8?B?d2MwUlFPNlVlVFNXbHRBL3hVaEF5WHVoNmszMG56NTRmajB4dWR3STdXWDF6?=
 =?utf-8?B?MzdRRG9zQ2g1dHF1anl0QnBQd3Q2Wm15bkV0Qkp6VjNWQ0IvZ1d1WVYyd0Qz?=
 =?utf-8?B?N2RpazBXTHVMcm9KRCt2ZEZLOHh1ZTJ4TzcyQTd2Y1RWaVlPb3VaT01zWjgy?=
 =?utf-8?B?L3UxWDJjOWtoOHc1OFNiKzhGMmdjYkNYQkNVM1IvT0RHRHI0aVV2YTYxcFY1?=
 =?utf-8?B?bXRKVjRtbGZsdzdNVWFITTFtZTdQbDFsSU9HTGFMUXZPSnJ4Tk4xeEdFQTFZ?=
 =?utf-8?B?YTFZaUhIVG1maDNLTmg2SjN0b1U3dHFQeVZEQkhMTk1iQ1A5ZHlLTnVyUHRh?=
 =?utf-8?B?UUFQUnNDU3VLY0FERStzZXhOWGZuckptQ2FCdDAyQ1ZMVkhPcnY0bE13cWJa?=
 =?utf-8?B?MHVzWEtvV3N5WDkwekcwOGNKUFhKV0VRR041OEQ2M0FuanBMTFJVMzR3cjhi?=
 =?utf-8?B?R3VOZ0FKSW0zNGl1MUxVUU55Tk5MRDJHOVJqUyt3YVR2bWYvdUlLZndxODN3?=
 =?utf-8?B?R2U5Um9aZmYycWwvTXNaeHlFMElRbEczekJmTVRhbjRRWitWSHp6NjRuVHNP?=
 =?utf-8?B?eU00djlwRXFPbmorNElJaTFMRjg2MlJucjh0QmcyMGpaOGoyNDg1TnVSdmla?=
 =?utf-8?B?Uk82MTBiWVdQejh2THA4bk9nNmRvemFjMXhHM0hSTW9ZVnRUK3NLbWk2aXVN?=
 =?utf-8?B?L1pYQmxYWCtNUU94c0Rqa3QvYW5OWlRuQjdPSURjS2ZPVVgxb3pQL01LZEdW?=
 =?utf-8?B?enh0cnVnSkdCQmhUNTVsV0w2bjRTaWVBanlReDJDMGQ4VmxYK0I2OGY0NlV3?=
 =?utf-8?B?TnAyZjhjVjJKallmN09xQnJFQnM5dFpIQVRaYVgvYTJpbjlqUzluUUJSdjJq?=
 =?utf-8?B?bGJkLzNPMFBEMFNHZW5DdnRjZ09QMW1XejIvMmEzRkJJNnJKYURzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EF7B5BA994F8F41A30A58BADDE373AA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bTm60CX10Dy/4DWbav+IDrclLMwFI0Odj59CNDLI2t8SLAbW6nlamc2vKvUwg5alMDe4LrvPEbxj6JIcDumvE1cQyJaZSz42lWqmzMJGHfdZxha9Mrbgm+rieKwZaU9ldmkzPYfim8qTLCSUrq+DwsOF7mVnwgoFSj/tJefgFbc4BMPHXVYJC6eOqMC/231raFZaFHl84wIH2J6pfSVLDVNg+LLRUsbo6Fboq1sFqGkK+tgM+p/0Up+5uoXHsid8cN5mXLPYmNUK41z8l5w+oP/EtePWNqoRB42Ecmdjt4ZWk+8ERDRSJBnhuom1Qb0UcqEHUMqirDw36rwLuoBhbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff2f755-2391-4d5c-b4e5-08dec2d67a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 07:45:56.3142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Weuna0rbPTjRmTFXq3Av6Ps1L0H1FGe8JA/cy/B+9YdvqTbtKFKnm1+hZ4FsIdXlHh28SUcwXypxLLQkED4PwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7766
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIGEgdmFyaWV0eSBvZiAiVkFMSUQgTUFTSyIgZGVmaW5lcywgZS5nLiB0aGF0
IGNhcHR1cmUgd2hpY2ggZmxhZ3MgaW4NCj4gYSBnaXZlbiBpb2N0bCBhcmUgc3VwcG9ydGVkIGJ5
IEtWTSwgZnJvbSBrdm1faG9zdC5oIHRvIHg4Ni5jLiAgVGhlIHNldCBvZg0KPiB2YWxpZCBmbGFn
cy9iaXRzIGlzIHZlcnkgbXVjaCBhIEtWTS1pbnRlcm5hbCBkZXRhaWwsIGFzIHRoZSBoYXJkY29k
ZWQNCj4gZGVmaW5lcyBhcmUgb2Z0ZW4gbWFzc2FnZWQgYXQgcnVudGltZSwgaS5lLiAqZGlyZWN0
bHkqIHVzaW5nIHRoZSBtYWNyb3MNCj4gb3V0c2lkZSBvZiBLVk0geDg2IHdvdWxkIGJlIGFjdGl2
ZWx5IGRhbmdlcm91cy4NCg0KSSBhbSBiaXQgY29uZnVzZWQgYWJvdXQgd2hhdCBkbyB5b3UgbWVh
biBieSAiaGFyZGNvZGVkIGRlZmluZXMgYXJlIG9mZW4gDQptYXNzYWdlZCBhdCBydW50aW1lIi4g
IERvIHlvdSBtZWFuIHRoZSBzdXBwb3J0ZWQgZmxhZ3MgY2FuIGJlIGNoYW5nZWQgYXQgcnVudGlt
ZQ0KdmlhIGlvY3RsPyAgQnV0IGlmIHdlIGFyZSB0YWxraW5nIGFib3V0IGlvY3RsLCB0aGVuIHRo
ZSBmbGFncyBtdXN0IGJlIHBhcnQgb2YNCnVBQkksIHdoaWNoIHNob3VsZG4ndCBjaGFuZ2U/DQoN
Cj4gDQo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2VhbmpjQGdvb2dsZS5jb20+DQo+IA0KDQpBbnl3YXk6
DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
