Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC325C804;
	Wed, 19 Aug 2026 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157581; cv=fail; b=GzME/LeMWID//TUDWbCPzFXWKzkE6kpYSpxTKFxxdMDcAO1J2FtTlEZ1lQxow/C3iyUaH8XY3W7+riA6dsWZrQq9q9DH2PZFFSBEw1tIhONARQnpxa+JJLoVeNHoLo7O1Se4Z9RGOMMsPs0UKlMgf33ct3vrw3KXz3h8tygeBAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157581; c=relaxed/simple;
	bh=ewDgyvHi+1SbY7EBXOyEac8ATr+Esu8I5q4PQOnM2wk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OUx39UPro/9hXG78W+VbLiUHGHRrHUiDvLOiXDdcIIBf8HU3KHBMh/LlDz7FxY7N5ff5TwmJeULUKZSzSFNzzpDJLzDnvySzRGn1JwIkAjj9Eyi/gv/fEhL6IDDFex5ACqUeboFwTvc4SNYKsP9LOsPAms2+A8qY2Pu/bdxOvf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzRDPUzb; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzRDPUzb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787157580; x=1818693580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ewDgyvHi+1SbY7EBXOyEac8ATr+Esu8I5q4PQOnM2wk=;
  b=AzRDPUzbt55NKn3f1sAqCnzKckdSg1s9HnJUk/NtQCq7Atav25KgnGYZ
   WJPIZMMwxXslwZLQw1+2K9mGh7oryeoAbEKboIBrdg+gHUegwoYYKoyoC
   v7pPRA9eO8Kmc2d+SH6aJvUjY0BNZsd7Ku9hysNUkILYS5RRaexk4Gcy9
   zX5sHuaSM1K7Ieflam87gs2uNKD5+FasvXufgAiRHTufU5pPigA0VeXzf
   kxvRSeM7DF1So/BNlFYfT5lRbzPokEt7CzE39Cc4qq1K++VroxzUapijG
   8u6TENit7v4faL2mq5di+QVLxeeVfAfXAF7/FdT1kARZnm48yd+W7oQJn
   Q==;
X-CSE-ConnectionGUID: UIePW1/bQK+a9vyAGRo2Sw==
X-CSE-MsgGUID: /OktFtfYQQuNglDH5brerA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="105215496"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="105215496"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:39:39 -0700
X-CSE-ConnectionGUID: DqA9qOtlQHO0EVyBt5FT1w==
X-CSE-MsgGUID: HOd7e+JaQOioQic/2P59cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="261392174"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:39:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 09:39:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 09:39:30 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 09:39:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxPcI9gguybrbFPWOlnZ14407MO057tc1efASTcYRHD+nBnsh7Mx+ZhjMPcMtKwYmGxRSvPiT7i1DLkVwYA4Q4fDHIODscJEfqixNVW8eAcSPuv1bXTa1/cRD4X/TVqiNU2KZvTchL4ukUtLl1nvdqLLANxz4gxiPkJM1R3+f/GSCEwgTVtJ93EpDslN0rlrUukF+setejpHawDfbBIQUAIq287A8+FOje4pnKsee5/IdVQXcIi5+wnRUVfpK1pBhfSpd1QOWA5/cVBjS0DccMV51jRYTxy5bfjNXb3Oi/1dARfTEpORaClyqeK4zosLkLaD1mtd82tMZhltCAaMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewDgyvHi+1SbY7EBXOyEac8ATr+Esu8I5q4PQOnM2wk=;
 b=EqSlMQKrfAl0u6cvqWhGDjAMhGJ7pQsLkKdbyGUUN9NzMj8+2IKFo6dIxD1C4/iZFGYPQFzwJFkMQkktPH+qcDr8NIlgZa4vx5W1kx1TldXJiYBiNemHqa9h+X2w4ycEJKLdZDNAv3I3kLncs2pmk2nwavnPKP0/wbn78TSp2XaLjzREeXxhMh2sLbPErabfdFVg9MyELOmzfVucpHSLYXtOf0gpb9ICp6wdFx9/WQj0GT80aCU+rJnHZK0e/gBvoQWcD6kPq5LysVtHyWZGWeSB50/XA69GmOd7pZoiDy/FGytLEyebNbiQ19hszaZaPw/o11bnQjuuvDtYIYMq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by MN0PR11MB6277.namprd11.prod.outlook.com (2603:10b6:208:3c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 16:39:21 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 19 Aug 2026
 16:39:20 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Li, Xiaoyao" <xiaoyao.li@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH v4 2/9] KVM: TDX: Check if there is valid exit infos based
 on vp_enter_ret
Thread-Topic: [PATCH v4 2/9] KVM: TDX: Check if there is valid exit infos
 based on vp_enter_ret
Thread-Index: AQHdL8C+BElB90R58EChBP1LxiY/5LallAcA
Date: Wed, 19 Aug 2026 16:39:20 +0000
Message-ID: <71de12296f46dec7753f9dec2ac08df97b49e8b8.camel@intel.com>
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
	 <20260819094903.3060020-3-xiaoyao.li@intel.com>
In-Reply-To: <20260819094903.3060020-3-xiaoyao.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|MN0PR11MB6277:EE_
x-ms-office365-filtering-correlation-id: 4b34578c-ab01-4e18-32fc-08defe106b36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|38070700021|10067099003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: qJ22BV1233yCKb7eghvmhDlSNXJiihq8R2C+dEghSPIqYTMVZDIZymQd9uXavC2szT6zeFvFaj79koMiiCokGBqQSQ7GEN2HFXyb0VLIl6FY/zq+ZCoRJxxP1NY9Uz9BEa+e+K4njtoK3nLPPU2mOoh4uMFeQD5TlYmNeo/Yd6CnafoK5Ytq0UI4B/pDHstY1KS3eYb5znYGr91f6XleJWgmpemj4/J2PX75Oai9KpgF7z/+mWVi0ctZZ3ejzDSqtgxGTRk54hFjE3Z3/lc81rN+UIf1R68Yt+GKmtH5/LnYEkpwDDIZrtf8u7H6vdZ4RjqakbjvCCxdquu4HKDD8yb1qyRnTqjGeqZz6pk3CMBydshQqmZtgh65tcYIO4zhgbh7Dl1I5766O7IkfadmEFPlnqGmQvCZktIHZF1MjmHv0BWdAmFHMJPubwZjSjcDQZ8pizqd36/9beFtC8jNRjMeq98gtnBmVPoETL4rCo1jxBM3jZadkvLWnuWlny2i8/cfmQJi4UCQMQXgcxngP438+Dnrl65z2BwjZR7P6s1qAxzsqCDLugvf4Qxz2Swze8y0yfb8zdCAoO4gJeWR9AR56+gbX53HrFwK2FUUraazE1lxlgVs5HQ28ssNNyyTU876afkPBVrWtR7o+sMwJTC8d3ba+1HyYXhy2+hcvvQk99Pg4ZOcfzLhtUecCn4MMIlqqptwyVFOq6JnPuMHaCQjMEI0iYHexr6V6pd/SpI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVlHVE9IWHZxd0JDK2pEelJTd1hua3ZBSHc4UCs4QXd3bmV0Sjdsc0VKbHZ5?=
 =?utf-8?B?Sks5UlFJZkNzMVp5eUhpTkxDMUxEV1Zla2Q0dXBXQUtYWTlxamxJdTdGN1di?=
 =?utf-8?B?VndBQ09KZXg3MFA0cC9CL1lLQmdpSFhYbndwRVdyRldWVUw5TVhTS0k4OFVY?=
 =?utf-8?B?UTMwMzc5eUkyVGg2Q0pMN2JMcG9iNUFtR0VKYUM4cDZFRlNMaG5uYVN1R1N3?=
 =?utf-8?B?bzlmZzZNK2JvVCtzVkhUeFhPeE1uY3BPbTAwQS9LaFpVbDZVb0NmZWNJVUVE?=
 =?utf-8?B?REJ0QUJla3AvZWpFRWVkT0kwTVZjbzIrMkVQR2hDV3J4MXhNMWs0dG8yZ1V3?=
 =?utf-8?B?eGkyQzZOMTI5cWg5WGV5L3ZFMnIwYU9SQ1B3RGpQaElpWDJmeFZ5UkYyTE9G?=
 =?utf-8?B?bWwvdUN6cW51S2VpNHpsVTFiS3ZvNDZaMUw0a2FweG5jeEwycmVpZ01OSEZV?=
 =?utf-8?B?UEEvZEdERDMyUVpmT3NFWHFBTDJsbHRpQkNlTVF2bVZFNlJkbVZraWZnYWpW?=
 =?utf-8?B?SGtNemtQZnA0TWVWS0xEbmExeG8va0c5ek1jNWx3eWdheHltY3YxSGJrSTJS?=
 =?utf-8?B?OGlnQjYxZlZMZElOQzRoWGo4M1RqWGU1RU40TXZLMjlFUDUxSnk0V0ZNcmFX?=
 =?utf-8?B?YzM1Y2xtTUViSy9hNnp6MXZ0d1dvUFh3Skg0SWFpaTdNYys0ZjliTkUyVWxD?=
 =?utf-8?B?aEFKTndCSkpVeGE1MUF5VjdRQklGWWYzd0Y2NkpXOVNra2J4Sk1panN4THlD?=
 =?utf-8?B?R3gydG5NOVZPK3h0L3ROV3pRNUN3bGcxWFliaEZRNFVtWWxOM0ptVHRvRFdq?=
 =?utf-8?B?bmdybmJ4S1VGcURubkpaeU1ndWNFelIrS3Q2RVNSSk1EOVJQTlRwVkEzcGtR?=
 =?utf-8?B?enQ3NzFldk9wTzQreUNubFdFd09pdDdpcEs2SDZEM0ovOFB5QlZHN05TdHg1?=
 =?utf-8?B?c2pGd3pKQnFSc2RDbFJZbmlSanRSczZ1b2I1UTM5MjZpU3lFVUtianJ2amho?=
 =?utf-8?B?dTlsaXZEMnZDR3g3TDFid01vcVN2SXN5bkhJZVU1L1MveHBBODVxQWdPcVN5?=
 =?utf-8?B?bWV6NXUwanlGMGxKSk0vMkRNblpNSnIrMktDb29ienZSdDJ2NFIyUGtyVUw1?=
 =?utf-8?B?MTl3TU0zZjhRQnJsM3hXUjhXQ0NnT043WUxDMGorditpdkNrdHNLR2dScFJq?=
 =?utf-8?B?TVNka2RiWmE0ZDNZRjY3V0M2RG1oNU5HMzRMQlUzWGlJSkdMazF5aHNKVW9D?=
 =?utf-8?B?UDNZeXlGcFQxWTRNd2NMNDJTd3ZIbzFBbk5XWkVYd1NpbXp0K0JwWlowaGhG?=
 =?utf-8?B?VHFOVFpCazZ2dkxBNzBMUFc3YzRROFlYTHBuYjVhamowdS9IZUlWZ1ZqbTlw?=
 =?utf-8?B?eSsyeFNXTVNvL0plZFpJckdwbVVmWkdLRm9XUXhHRURmZWxJWDhuWUtSc3M2?=
 =?utf-8?B?VXIvRmJXR3ZNRnU0YVU3S1AyRzBoWTE4ODFHTXQ1bUNjYzJiSEh1dHF1bE0r?=
 =?utf-8?B?ZHRSalVZdWlyS3VWMHY0SXdoMVU1a2p2OHhHSE5qN2g2a1VQN1pxY05KT1VQ?=
 =?utf-8?B?R1BYOU9nSVA1L21rc2E5Rk52MEZkWWQydktBYmsyd2Q1Wm5Ud3FXYlhuWmNr?=
 =?utf-8?B?eXZsdnl1NHlkckxjNjE1dGR0ZEJlUDlTd1V6QXVJVWdjQUxRNkFYd2tXQ01Z?=
 =?utf-8?B?d0xIOGZ6WnVuSWczMnJYYmJvVXR6T2taREhhSFZuZ1piZ0M0SHRJcFZWdmdR?=
 =?utf-8?B?Vkc2aGpiTnNUcTBqTFFpaWhUcmhRdFV1R2k5NHl0Z1dOcWJCQ3BKdnVNWFoy?=
 =?utf-8?B?ejg4WG5pZmpETnZoRWkyb3FST29NSk9vZkdJNUkxZjNFU05KWk92bnk0dG9G?=
 =?utf-8?B?aStLc2crdUF1UC9IeEdtdXUrU2FscDBNWERSbEpEZzRnZUo4NWxqK290ZCtI?=
 =?utf-8?B?a3FlT0NLS09wWTZpUXJsa0R3b3RlcEd1dkludFFGRmtJNExWVU05cGZteWtl?=
 =?utf-8?B?ZVFNMWpiNjdoYUVxcW0xTXpZWTVGNDlzRE1ZRXNYSDJuQWQ1NWpVbkJ5NVNY?=
 =?utf-8?B?dlhteU9tc1VJVlJGbE8xTkt4aHRLZkpYK0o0UzljQU5Qb1hxTnBxM0l5RDA2?=
 =?utf-8?B?c2U2bmU5OThpQm5aYlZyelViVHBteVZFTzhmSWhGckhETXErYlBnbVJ0QTNn?=
 =?utf-8?B?dU9TRHMvM2d5Y2JjVHN4SmQzZ3JxZ2NhMzVhSkFMODVVcXdpbjlOajFGSEFS?=
 =?utf-8?B?bEhvbkd6aVlwQks0Ty9BRkZ3VU42TVlvQ2VZVGphQ0M4QnVocFE4b2dGbFc2?=
 =?utf-8?B?Ni9FSzErZnZqMjFoK0F2OCtud2FmMUZ2ekpqU0dVaWcvYU5WUUNORCtWTm9y?=
 =?utf-8?Q?dGI5dYprCTV1FhxI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3289D8F31101C4A89AA851D6827DBEE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GWF1m2lTqgSlj5z/56lbQrY4N0fWAGnRUcolf7cUhfRrQiIed3tw6s7yR8dkCDj7YaBd5F4+N53boYyzgzTksA3cvpO1CmxQVfwL6bbiA+FKILdtoYvcqb8h/IVR9TDG/rDzQ7h7hZn4LgaH6zkKFS/0qDiiHQY28UTH22BuUjXTIAl8uQ2TgieBpnh0ItoY13tfMwyhlsmsapxtAwRqas36eqOkF/JU6sMqBD+h3v7SkG3uQ7i/QCLMPLdI+VByhCCbslcEDYXH75x1iGZP6vNn3nkxuGIXTVD9HOk6PD4fcrpm5jm9nVOm25EjXxI1FZrHXKvGYrGGpaQRWyZPoQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b34578c-ab01-4e18-32fc-08defe106b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2026 16:39:20.4389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9gIMNx/ASAZkXCOPGYpFDa3SAeh/INSn0oI6kkvrWkFTZbeeHm+0XXM4xjmeXMZu+fodrOcqSu7J+iOj3Qpi1ihOdbS96HblRwXalxI7Sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6277
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTE5IGF0IDE3OjQ4ICswODAwLCBYaWFveWFvIExpIHdyb3RlOg0KPiBD
aGVjayBpZiB0aGVyZSBpcyB2YWxpZCBleGl0IGluZm8gYmFzZWQgb24gdnBfZW50ZXJfcmV0IGlu
c3RlYWQgb2YgcmVseWluZw0KPiBvbiB0aGUgY2xvYmJlcmVkIEV4aXQgUmVhc29uLCBpbiB0ZHhf
Z2V0X2V4aXRfaW5mbygpLg0KPiANCj4gQ3VycmVudCBLVk0gdXNlcyAiRXhpdCBSZWFzb24gaXMg
bm90IGVxdWFsIHRvIHRoZSBzeW50aGVzaXplZCBpbnZhbGlkDQo+IEV4aXQgUmVhc29uLCAtMXUs
IiBhcyB0aGUgY29uZGl0aW9uIHRvIGlkZW50aWZ5IHRoZXJlIGlzIGEgcmVhbCBURCBFeGl0DQo+
IGFuZCB2YWxpZCBleGl0IGluZm9zLsKgIEhvd2V2ZXIsIHRoZXJlIGlzIG9uZSBpc3N1ZSB3aXRo
IHRoaXMgYXBwcm9hY2g6DQo+IEtWTSB1cGRhdGVzIHRoZSBFeGl0IFJlYXNvbiB0byB0aGUgc3lu
dGhlc2l6ZWQgaW52YWxpZCBFeGl0IFJlYXNvbiBmb3INCj4gcmVhbCBFUFQgTUlTQ09ORklHIGFz
IHdlbGwuwqAgVGhpcyBpcyBhIGZhbHNlIHBvc2l0aXZlIGZvciByZWFsIEVQVA0KPiBNSVNDT05G
SUcsIHdoaWNoIGhhcyB2YWxpZCBleGl0IGluZm9zLg0KPiANCj4gVGhvdWdoIHRoZSBpc3N1ZSBj
YW4gYmUgYWRkcmVzc2VkIGJ5IGNoYW5naW5nIHRoZSBoYW5kbGluZyBmb3IgcmVhbCBFUFQNCj4g
TUlTQ09ORklHIHRvIG5vdCB1cGRhdGUgdGhlIEV4aXQgUmVhc29uIHRvIHRoZSBzeW50aGVzaXpl
ZCBvbmUsIHJlbHlpbmcNCj4gb24gdGhlIGNsb2JiZXJlZCBFeGl0IFJlYXNvbiBpdHNlbGYgaXMg
YnJpdHRsZS7CoCBJbnN0ZWFkLCBjaGVjaw0KPiB2cF9lbnRlcl9yZXQgZGlyZWN0bHkgdG8gaWRl
bnRpZnkgaWYgaXQgaXMgYSB2YWxpZCBFeGl0IFJlYXNvbi4NCj4gDQo+IEZpeGVzOiBkYTQwN2Zl
NDU5MDggKCJLVk06IFREWDogSGFuZGxlIEVQVCB2aW9sYXRpb24vbWlzY29uZmlnIGV4aXQiKQ0K
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTdWdnZXN0ZWQtYnk6IFNlYW4gQ2hyaXN0
b3BoZXJzb24gPHNlYW5qY0Bnb29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBYaWFveWFvIExp
IDx4aWFveWFvLmxpQGludGVsLmNvbT4NCj4gLS0tDQoNClRoaXMgc2VyaWVzIGhhcyBncm93biB1
bmZvcnR1bmF0ZWx5LCBhbmQgSSB3YXNuJ3QgYWJsZSB0byBjYXRjaCB1cCBvbiB0aGUNCnRocmVh
ZHMgZnJvbSB5ZXN0ZXJkYXkuIENhbiB3ZSByZWFsbHkgbm90IHB1dCB0aGlzIG9uZSBpbiB0aGUg
bm9uLXN0YWJsZSBwYXRjaGVzDQphdCB0aGUgZW5kPyBPciBtYXliZSB5b3UgY2FuIGV4cGxhaW4g
d2h5IGl0J3MgbmVlZGVkPw0KDQpBbHNvICJLVk06IFZNWDogUHJlc2VydmUgbmVnYXRpdmUgcmV0
dXJuIHZhbHVlIGluIHZteF9oYW5kbGVfZXhpdCgpIHdpdGggYnVzDQpsb2NrIGRldGVjdGVkIj8N
Cg==
