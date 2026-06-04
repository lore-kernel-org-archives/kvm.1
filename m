Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4493D75A5;
	Thu,  4 Jun 2026 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571369; cv=fail; b=B9rHQ3afYcnf5aVX+nDEqxuc6lAQ/JPbeqNZC0JBQv+fCXqs4ax8mhD1on5V0ewUJxk6OXWepZ3EPbJA3eVF62zJJt6UfFRka4PJh9mV7Hy+JzDX0Yt09sT0i/++9APM3rDyrISfFPkH1LjLLatFJf1lzHzPnJ/FAzgUFxe+nng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571369; c=relaxed/simple;
	bh=Rr1qQT/LlPpg8XgJ0MVjLDclqxGWYH58orvq+RmXUBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B24xM+hinXwjzxbNqfnosvJBZkEvIr0mGut46HFfKWflpAJ36LokRLCFsupUU5inFPqJnmWz13nkt+PtADi9FEUsoALexbmYvaziHx+wE5C5vgvQhEue/jHW+0oLBYLZc+xkTEJ3ZGF1JLsbmcC58ksoHoimU557KswlVU/A2RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ym/itB1c; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ym/itB1c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780571368; x=1812107368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rr1qQT/LlPpg8XgJ0MVjLDclqxGWYH58orvq+RmXUBs=;
  b=Ym/itB1cuIpUC1R6QmEHATgZCTTcrNiEyxFfbtocMGS9kmJG8DWfci4m
   n5gt31RruoyslwVCxL0X7p0JSLbLO3P2IVxoui+lRHgBXQLNZOKnb0FOv
   1lVmJClcOTBhytsBKxEa66KaVABNpRgcLw7Ge3gzZAHdH1zXDjaDhpq56
   TgP/LRcazYgpCLylLSTG+FUl68rUa5V/YsAISUcHYCpfhHfvVgkzYGV/Q
   WOg68v68laMsksrnjfEkILIZySYMVs7YvltjsdwXJS7I33ktE6WIHOP5x
   jSeo15trYtirXqgE2HC+ma86r4Z0Kvm36NfaAYsDq27bgHUHQK7d2xz5x
   Q==;
X-CSE-ConnectionGUID: Kh8ZeKMOR7+zO7lVHjUWYg==
X-CSE-MsgGUID: EOInl/nNTmilt4ALhrotTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81252207"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81252207"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 04:08:53 -0700
X-CSE-ConnectionGUID: thmcEUDrQMCUIDc6y0GqbA==
X-CSE-MsgGUID: laCuSnymTk6JnbyJnkQmwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="249611076"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 04:08:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 04:08:52 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 04:08:52 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 04:08:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i79PcXvZ7CWWkcDbp0CO7LZSJxwBgkrEbmUerFncucLZrdZTgBUgQbFMNJ5weV55ddlGvwVtkeyhDfA6J2C6T5+BF2rZU0zuAyKseEfhNkqerVa14BG8jZhPv5BgGIP6wmJUSnJQxZXMqjOQn747kh54S1Hej/7+dL0JmYJUcoqNU4NlkNva+orpE4qZzSI1WHWIKWyGNarKs5O6aDYF4BcnqsfikVxk/fAPrqKvcbxuiAxybkgjmnPXfWZfx6yEGSLa8wNaQkhQJQtSXjssBNcXgeIOqBM14Thu4xXSFGNoyMXYMJmbiNoFGHS4mIQXPzyhTT+HReWMQRZc39f33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rr1qQT/LlPpg8XgJ0MVjLDclqxGWYH58orvq+RmXUBs=;
 b=yYFwb1cfx5SB0d0MKOvP2VV+IdyWaIuNp52bxjxtH/yILsvhMZ5DJ3D21QBl+bi4oKZyIfdw9fZiejGFN2K2JjSMbLB0tJ86b3j+/X20ACkJt18fKe2RMHAGQkzuhPDK62N6shjWkh69PgPSfvMjUNxJXRjOzvpiMnFBKa2+jaTrrC11/CItkNRlRXP6y8UzB5/kzYNTqUpguubajulitlrIa50IK3EZdDxDtASQtT8b7jDm67U3Yn/BCPtyr2cryptJDwkKYca7iXCtUzYFroz9OLR+pwF9agLgXMpO9fN2m87eS9+hjoRzCdpu4Y6NnN7I6aDisCjwkYyLvQ+Hzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 SJ5PPF09F392AFF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::808) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:08:49 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:08:49 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk"
	<dwmw@amazon.co.uk>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: Re: [PATCH v3 23/40] KVM: x86: Move kvm_{load,put}_guest_fpu() to
 fpu.h
Thread-Topic: [PATCH v3 23/40] KVM: x86: Move kvm_{load,put}_guest_fpu() to
 fpu.h
Thread-Index: AQHc77nE5HY7ZCJpu0qG0zXZsNTAZbYuRZOA
Date: Thu, 4 Jun 2026 11:08:49 +0000
Message-ID: <b615b8eab2929f8b64c220bb4cb9fd4a917db472.camel@intel.com>
References: <20260529222223.870923-1-seanjc@google.com>
	 <20260529222223.870923-24-seanjc@google.com>
In-Reply-To: <20260529222223.870923-24-seanjc@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|SJ5PPF09F392AFF:EE_
x-ms-office365-filtering-correlation-id: d9258af0-43fa-4a2c-4c92-08dec229a76c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|4143699003|56012099006|11063799006|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: CxKeKwE+YX744VVqBkCFaA0gi3wEGPKcGvnB0wO957bqjGzrheYl4O4YY9ySdjtwGumY73JqAsyaYEE7ATQ/AZd+dTEOsnoBCdGlmjhpSqLS/he2qfAxKIoD1eAzRdI4/2kgp2wU4Lc+hiKLepIOZdP0wRxj6Q3g6sHjQ7POUWnZOs0F1w9Th8r6mc2nBNugI5l81Nu3KZ7xR3uYO+zMnslRIk6I1ZuyDI2aTol7b4EJUi3GLZFV2WipLq2qypD9F0cP+GXmeo32X/MP2cwFX2vJLfob8q2og9STQ11W1FtyKJZ9wkwtXLh8CGlEH+dbUjgePoT0+avA5QytdRcNYu4DY0eQqGDaLFu5WvOV7e3jrYDWBXZayDwySxgynkcAmQllnhbIA9B8D6nnfmpKyaCe9St/pS6TNaoWcDXV8+vcVQxDbqCv24OGEZsC2qL6ymqoZihHbSdx+7S7RD829h8G+j1ZciJutfX4v/xh97OLtF0x6E+tws1Pn03p2JHtGuGpScvvHcQmNm1uuPVvibbqXG89mP7xCbGtSS5CmJDguhdEWhubhEFsgmbPqe6El1Q8uekf9jLY25bMqyEmSivFiRNKHgdHUAYJw8DMtbyrwuucaqIHOw1nEvFMKTI3gPnLAtft6tbHsGeC3B0vLYLQeHveIHi3GilNpZges77XkSASR0zYaxFKbHEEM4Dn1EiMCKZuDqbYQ39MO/mo03gLckFVNB7dXzZVBXpZfyPfZsqt6R/ZzV9Foj/7s4t/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTFVNGQxcTliVldLZ28vSDRmK3h3dEo4aEcrUnVMMzZvbWxPS0ZidUpzRmx3?=
 =?utf-8?B?ZFFFb1BhSWVqbTVTZnZnTmRWYXpkQ2JzdUIzZWdRTjRTOXRKU3pGR2VsRS9E?=
 =?utf-8?B?QWdYUTBsdHo3RmNrZzBPRzZXVFd2b1ROOFdPUTNXTHMyZ2pNMGxKZ2J3WnJV?=
 =?utf-8?B?czZoU2YyUlJyL3FZV3I3cEdyaW9oMGNFQzRUN0M5akZWWVZlODRiZTdnaHo5?=
 =?utf-8?B?MEtic0tqZi91ZENMS1VFVlM1TGNGOThWeU9HZW82VmdpdWljSW1LU21tcXpa?=
 =?utf-8?B?UmxtbjFYaDNUYzh4bUkvS1FiWFllMUJyVFo2M1BIZDB1NGZnTHkxWTR4SFJ4?=
 =?utf-8?B?d25BOFZMckRXTjUzVCttRFM4d1Y4RXAvbHVOVmh4bFBSUTF3R0pIQ2o2MTJJ?=
 =?utf-8?B?L3FZNVEzZnE3dVFVK0Y0eXhkMFdvSXlYVGt2Zi9tbDVhMFQwMnFLOUpCYnBM?=
 =?utf-8?B?TDQybUM4elUxMXRyVGJYalBoLzhBKzNnN0tuNVBUUVpPZWRxWW8yMUppcTJP?=
 =?utf-8?B?QkJOLzlhZzFDd3F3SFM2UE05bi9ZUUNJdGlyOTIyaWZ2Yng2dWhDV0tSR3RK?=
 =?utf-8?B?RWxXMFRLV0M5c2RiK3hnVThLQVl1U3pRWEpQRm94b1FDM1dzSGdWd25rTlFP?=
 =?utf-8?B?Nk1HcGoxRUNDQWRtakREUTJxMUFNamxta1FXbjZ3UEh3SnJDMEp6dlhqeEFI?=
 =?utf-8?B?ZmNwOGZlN0c1R2V2VzBjc0Uyb291YitrYVZSYU9MTUJsOSsyWElWOVpKSGpX?=
 =?utf-8?B?dkVIb1JoRVJMZ0pScFFYS1l5eFBQV0ZnT2pzMjJkMjErdzMwV0NZZlJaLzhv?=
 =?utf-8?B?VXFSWjFrOU5XeTc3MForRmpNSlJIakdtMG55Wks2UHhCV2kxdmhsQ2hjYTU5?=
 =?utf-8?B?VFZZNlJoV3RJS0QzU05ya091aXRMcmhXTEovTEtLUmtqNitwa2l5U0h6cWdO?=
 =?utf-8?B?dytYOGxxOXZJVVEvUnVrVU83bkNhb1lPS1pUTnM5Wkxmek9UQ0NPcTdza0hQ?=
 =?utf-8?B?R2pDYlpBamo0QlJVRXI4UHhuamM4TnMzSkpsVFZmUUdodXZoczdieHJTZlRt?=
 =?utf-8?B?U2NPbTFvMC9VRHZFaXJMT3NuQnBYOWdoVVR4Zy8rSWxSL0paK0dHQ1laRWNG?=
 =?utf-8?B?WklhSjlvV2tWVXlnR0xDRFJsUlNPZGlka0xFYVpLeDByRlJxZFZrRi90dExF?=
 =?utf-8?B?eDlwMmFUNWEzQlVrZ1RqRGhqVG95M08rZVRuL0U0TDF4aHVIamczd2NiQUtI?=
 =?utf-8?B?ditoZXFWSUYwTkYxUzBDZnBYMmdJYzhzeXU1OU1PMWRuTmpMbWJlWExrR0lT?=
 =?utf-8?B?bmV4anIveVcwREliVXRCckQ0b2IzVGhwVnl0cXUxSlJvbWhoQUFpb1NzM1Na?=
 =?utf-8?B?YlRCRWgvU1E3YjZSVFc3QkxpNDJjdUxxbFRGM1RXNVNUcTkva0Q3V3NSOXFm?=
 =?utf-8?B?T05RbmFmOFVCWTcwN3drZ1VzcmF3V3RZTDRWbW5pSXJRMVd5WWdEWDloZVE5?=
 =?utf-8?B?MFdqZHc2UGhFV3F0Z1pubnZaVXJNQllBYzRLajFEaEtsL1JWNDNYVE1SRnlo?=
 =?utf-8?B?UW1uUis3V2liWCtxM0hETlZHNzNib2d1cEdPT1NWdkZ4NU9yYmx4TG5vOHM3?=
 =?utf-8?B?TEJiVElPNDRJTk4rdG43c0hlQ3IzV0dSRWwrZkVPVTIxME9GOWdCZmlYY1VM?=
 =?utf-8?B?R3QvV3h6QjdFR0l4VTZFUTB6UWxBaUFweGg0OHlSUENLeVBmQW0rVFo5THFX?=
 =?utf-8?B?Z3g5K213aG15V1RBTjhyZldpbThacFdTQmVTVUhyZVh0SENyZ1FwTWFvYUxM?=
 =?utf-8?B?YkFPcitNcER2aitJdFY4c3hTdXBpWEJFK2tyRVF5ZE1Qb1cxQkNVeFA3Vzkz?=
 =?utf-8?B?U0xJWGxsNU5aa2Z3enBhc2JBV3pUR2dQMmR4WGUreGtVNDhyVG1OdXJJZmNQ?=
 =?utf-8?B?L0R0OG4rQmFKUzBUUlVuWlRlMWlyMG1PSTZUYU16NjdlYzRUUjNCS2UxakhR?=
 =?utf-8?B?UmFKcENORFY4czlaUW9hV1hjbmtRbWlOOG9HbkxKQUVxcTRYcW9tSUtIY2lW?=
 =?utf-8?B?TUd5RU9nL1p0Tk1kQUxLMldNTElTbTVPenhmY2JZY2JUdGtZUldieXU1SUVu?=
 =?utf-8?B?TVBQcXlNOWYzVU5SbXZuenVkUmgwU2VyUTllWjFNaGZ1RXhaRSs4ZDhRYmEy?=
 =?utf-8?B?a0lSWGFNcW9sWlZNbFJGc1NqM2dTc0J1V3VmTTRkNGNKUURSRGhFdEVoeFJ6?=
 =?utf-8?B?NHlQcWpCeWNiWDJueTJNMWxWUFhJRTJvMXpQMGZBYU9qNlpXeUhlOGhBeUZa?=
 =?utf-8?B?cEl0alplQWdGVUNZaWZZVzhuZUg0TzdRMmRkQTJqN0g0UjIwRUVFUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB5B2B7833D5BE47BB43120A40C0AB00@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SQYLSFN242qAxjy3TKIfEp4Fam0UVO7LI/fef1+ndqH+EfwQlpR9hxA+yF6IrZ38HE5bPZHsE6rlUIdHjvuTLA6dr9PBvdUxFV5+B3JYinKywmV8fRS8nDpwKBkV4FLl1LkO3LkEDXYGi9QdG426vTmtXRW/2huw+0TaEbdBOsEUxYkX3cq8I6WT+hpBKUnjUurQvSS4acRtuG4iL0oGltls6fJ39gDYAvUWp0Y1rjM8YHPXJVg7jLc94YLE+m3SpUtuq55SIB/j0UYqmlegxc2ZD4kK1klMaT3Sv6N3RQWpdKyDqnR2jV1/8qspgBRB6gAtB+ROK1gy/1PwMsmZxg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9258af0-43fa-4a2c-4c92-08dec229a76c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 11:08:49.1137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dh0IU9hfkVeefrTMQ110FR3DAcu7u7TpIKsUUkp+8fVjaQx05xTNQJTjOnbbjBKMKTB/nPSXUAXn4Yb924cILQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09F392AFF
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI2LTA1LTI5IGF0IDE1OjIyIC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiBNb3ZlIHRoZSBrdm1fe2xvYWQscHV0fV9ndWVzdF9mcHUoKSBoZWxwZXJzIHRvIGZw
dS5oIGluIGFudGljaXBhdGlvbiBvZg0KPiBtb3ZpbmcgdGhlIGJ1bGsgb2YgS1ZNJ3MgcmVnaXN0
ZXIgc3BlY2lmaWMgY29kZSBvdXQgb2YgeDg2LmMuDQo+IA0KPiBObyBmdW5jdGlvbmFsIGNoYW5n
ZSBpbnRlbmRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNl
YW5qY0Bnb29nbGUuY29tPg0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50
ZWwuY29tPg0KDQo+IC0tLQ0KPiAgYXJjaC94ODYva3ZtL2ZwdS5oIHwgMjYgKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gIGFyY2gveDg2L2t2bS94ODYuYyB8IDI0IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyNCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vZnB1LmggYi9hcmNoL3g4
Ni9rdm0vZnB1LmgNCj4gaW5kZXggZjg5ODc4MWI2YTA2Li42YjdiNjI4ZjUzMGQgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gveDg2L2t2bS9mcHUuaA0KPiArKysgYi9hcmNoL3g4Ni9rdm0vZnB1LmgNCj4g
QEAgLTMsOCArMywzNCBAQA0KPiAgI2lmbmRlZiBfX0tWTV9GUFVfSF8NCj4gICNkZWZpbmUgX19L
Vk1fRlBVX0hfDQo+ICANCj4gKyNpbmNsdWRlIDxsaW51eC9rdm1faG9zdC5oPg0KPiArDQo+ICsj
aW5jbHVkZSA8dHJhY2UvZXZlbnRzL2t2bS5oPg0KPiArDQo+ICAjaW5jbHVkZSA8YXNtL2ZwdS9h
cGkuaD4NCj4gIA0KPiArLyogU3dhcCAocWVtdSkgdXNlciBGUFUgY29udGV4dCBmb3IgdGhlIGd1
ZXN0IEZQVSBjb250ZXh0LiAqLw0KPiArc3RhdGljIGlubGluZSB2b2lkIGt2bV9sb2FkX2d1ZXN0
X2ZwdShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ICt7DQo+ICsJaWYgKEtWTV9CVUdfT04odmNw
dS0+YXJjaC5ndWVzdF9mcHUuZnBzdGF0ZS0+aW5fdXNlLCB2Y3B1LT5rdm0pKQ0KPiArCQlyZXR1
cm47DQo+ICsNCj4gKwkvKiBFeGNsdWRlIFBLUlUsIGl0J3MgcmVzdG9yZWQgc2VwYXJhdGVseSBp
bW1lZGlhdGVseSBhZnRlciBWTS1FeGl0LiAqLw0KPiArCWZwdV9zd2FwX2t2bV9mcHN0YXRlKCZ2
Y3B1LT5hcmNoLmd1ZXN0X2ZwdSwgdHJ1ZSk7DQo+ICsJdHJhY2Vfa3ZtX2ZwdSgxKTsNCj4gK30N
Cj4gKw0KPiArLyogV2hlbiB2Y3B1X3J1biBlbmRzLCByZXN0b3JlIHVzZXIgc3BhY2UgRlBVIGNv
bnRleHQuICovDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQga3ZtX3B1dF9ndWVzdF9mcHUoc3RydWN0
IGt2bV92Y3B1ICp2Y3B1KQ0KPiArew0KPiArCWlmIChLVk1fQlVHX09OKCF2Y3B1LT5hcmNoLmd1
ZXN0X2ZwdS5mcHN0YXRlLT5pbl91c2UsIHZjcHUtPmt2bSkpDQo+ICsJCXJldHVybjsNCj4gKw0K
PiArCWZwdV9zd2FwX2t2bV9mcHN0YXRlKCZ2Y3B1LT5hcmNoLmd1ZXN0X2ZwdSwgZmFsc2UpOw0K
PiArCSsrdmNwdS0+c3RhdC5mcHVfcmVsb2FkOw0KPiArCXRyYWNlX2t2bV9mcHUoMCk7DQo+ICt9
DQo+ICsNCg0KTml0OiB0byBtZSBpdCdzIGEgbGl0dGxlIGJpdCB3ZWlyZCB0byBwdXQgdGhlIHR3
byBmdW5jdGlvbnMgYmVmb3JlIHRoZSB0eXBlZGVmcw0KYW5kIG1hY3JvIGRlZmluZXMgYmVsb3cs
IHRob3VnaC4NCg0KPiAgdHlwZWRlZiB1MzIJCV9fYXR0cmlidXRlX18oKHZlY3Rvcl9zaXplKDE2
KSkpIHNzZTEyOF90Ow0KPiAgI2RlZmluZSBfX3NzZTEyOF91CXVuaW9uIHsgc3NlMTI4X3QgdmVj
OyB1NjQgYXNfdTY0WzJdOyB1MzIgYXNfdTMyWzRdOyB9DQo+ICAjZGVmaW5lIHNzZTEyOF9sbyh4
KQkoeyBfX3NzZTEyOF91IHQ7IHQudmVjID0geDsgdC5hc191NjRbMF07IH0pDQo=
