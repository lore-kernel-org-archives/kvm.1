Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5213DFC6A;
	Thu,  2 Apr 2026 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149610; cv=fail; b=eHPGHfC6tKQcS0OpCvCB5+Ee0bxZP1v/XLMCg+sBaIopvaezzSoJAA/otT6GhlwP5iCGrCZq81jKnkwTW8uKlsGoVtrJHm7wCTKU5bIgVmnYzzqYwMKp9VztEXhPhvA6TNlysI7hwgb3kX8ughyyzU3XRLCpgr8BpMhdcaXkmZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149610; c=relaxed/simple;
	bh=SvkGNqQBJ4CKQT9AgwhmBJ18OLjsfPtwjOkPvdHAsxI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=foWdRbxdWbie6MKknxRGycQPG7lAqSw6CAq6xodwKINhFvBEC7t7f/ZRAzWDYu1+C2staMIgn3YOxWN9BHC38UrnOCc+JykSKACoHqdx3gcGo4RhfFdTi2JBZcgfZSijR+Ozi2bABjwKrd5UxDDd1b+7pK/g+/M58K/zYGkgzAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfdPX/KN; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfdPX/KN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775149602; x=1806685602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SvkGNqQBJ4CKQT9AgwhmBJ18OLjsfPtwjOkPvdHAsxI=;
  b=mfdPX/KNeQXTbuoTRPSTDDdLBEj5sY8MMdjqzVcvm88YyeF2ZGYHO/hP
   oy86SaVhUBkGSfCUi9uZQZhPGzozaZxZ+WxwiIo5r/u8raHMihjaQn8rA
   0cHHz4/K8HoSqj9ZcBnKjmfv1a/lu9/+T6KLrYoVPDyWb0b2Ck+8StWh3
   tfPw/Dry8XlEPsS5++VQ6YBKVnanpkGsmdaz6cHpHSa1kriGNtlGi+nVi
   yY1LqdxhzRotAQmVx0Yv7V3//Xagj6p7Ha0xX/gZjtBxeotdqBWyE+JOy
   cX1sqvLNjJYwF+J3AEfpfwJkKh19ZzmrI2y71wMZEOLAxlcP83dlxFh1Y
   A==;
X-CSE-ConnectionGUID: XBDCIPtVToyjyufQQ/nZsg==
X-CSE-MsgGUID: BVq3TlhfRTOLYDJGDP1CCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="86834406"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="86834406"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 10:06:40 -0700
X-CSE-ConnectionGUID: GVQz2soPTQKtD68knQ2tKw==
X-CSE-MsgGUID: 6mhQmtYuRNWv/0xRzVchXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="226202726"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 10:06:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 10:06:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 10:06:39 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 10:06:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/T+8VWzPzSci7GpdyntiGnUpf5NAPsIObiq6JZ7+NLgM8YWC+XKDec7LloklL6xOK2+A48IfcvZxWQ39XjrW6+9qaxZ8q4DeIHkaztt7qPKoLh5iG9cYvIE8tfY+xQjYxJuXmzaS2S/Cj1DTyBDM/kJd2OyetZAQIKW1vj1zXEtbb7fE7kGTC9zFoGcxzLCI0Dt/F7c21rNPIweclxXSH+/0lib3RNdQBQAOjpcNiHbOYxIxvq6fhC8QWRay/nYpwyrc+3lZHhECZBee+eku1xcTjdNJhB3OXvlYL6egd5cfdVwV578j4/Z/iK081Lj3pnkLaWCR3NACEyVvZ5L7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvkGNqQBJ4CKQT9AgwhmBJ18OLjsfPtwjOkPvdHAsxI=;
 b=gWgIw3vVqo/gNJoP4YU5Jh06PzQnKQ/CSSNdOt78c8x/vfDOHeoq3ZNkZs7IQx8ZZcrLOlOUXnZFZF2gDkUpk0oZ1+mhF4amKpIVytmpSg5lyRBRRj46naa/yA71ARZWU1tfYsGTQD4rGbQ5G7dAtYiFz0Ck6a3Bforz6BWPUM4hYpv2wLb4Nd6JHT2Lhi66bElYtSUag8GSyPjQTMh5x6i5VzeeTFDrj2xGKNjaPR/OCkKoZliZJIP1V4L9nCTEqhsMX2kJEGO8p0D92XrigDhKjjmrOnct9shWhQMZ5xwOy/ldiQaIqZn/+cHjG66WUJwMz2oOEZb/nv1oyCxaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6785.namprd11.prod.outlook.com (2603:10b6:303:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 17:06:37 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 17:06:37 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "prsampat@amd.com" <prsampat@amd.com>
CC: "bp@alien8.de" <bp@alien8.de>, "marcandre.lureau@redhat.com"
	<marcandre.lureau@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Qiang, Chenyi"
	<chenyi.qiang@intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Topic: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Thread-Index: AQHcu6ISxXKhFiWKBUuIm+vE1xtYKrW+PPMAgADQbgCAAHNtgIABo7qAgAAlqQCABe0qgIADLMUAgAEXRwCAAJP5gA==
Date: Thu, 2 Apr 2026 17:06:36 +0000
Message-ID: <9b1290bbc1283a2f35bdcd177d27ae7aea89151c.camel@intel.com>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
	 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
	 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
	 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
	 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
	 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
	 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
	 <cab5371d-e0f4-42b7-bae9-2c7f981b26b2@amd.com>
	 <49e8b24d836c1883e83ad72d1ab279f9e3eb7455.camel@intel.com>
	 <IA1PR11MB949557E04741169BA209A69EE751A@IA1PR11MB9495.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB949557E04741169BA209A69EE751A@IA1PR11MB9495.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6785:EE_
x-ms-office365-filtering-correlation-id: d8a4cc54-1ca9-4ec5-6ae2-08de90da3336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 5AWFMRdmWs87w5kLBEzROD2miqO7HeUHYsOv/KdUE0UZJnT9GBGZ3lJ+bG/5n9xoeT7ljq7sOH8oKHgp81LcZsPTVL6SFWH4eM8n1PWmTLsEUHZVV8MdDSX9Ty+pJH6bAraXvZvp6yoQ+UFKQQSXomyjLlJ51KstzRH19BEgpty9+cOUkB7oaMP2wpFUmJ5slT24EY5RrY/tHoZO82MT4kGtdPfwe7mmzyY40nyJIhF+cFav0sVPXIfNkBoOP0VoVT/FTFknLm9hb4Yme/xAvEhpmbYSqf+xglYp02poisIM2thuERCO1nLAmSJ/yS+GeXEXHoBPq8gebzAW7Q1J+cNmmTrwHFPAOEjq1Hnpx7VZ3j0Uxgz4EQrAHg9wMm4REEGUW9MJWlk52mkSGZ3WaOSVvq9ZQ6VE6oXEd3f0ggW5fpVzyT2aH667BBn7eD/17GLePpPCTrsS4tzKz7f/asTbLQZOYEnmepq1N1Y7RCG7zzUYfSsyzwqo8F0jwFXpD57c654H7N8/sKzW5j/tIE1TsEngaVBnlra6Jbz3/aESjzx1im2z1M5nVvNGWYevm6FurZ0qBxpkUTvATkk3lbTUGd/+wwMvD9e3KcKt/2NlaFfRIfj/tn+WhqL2Wa0ArE7C9YaNO6cEpWJ/PWbRAeakirgCsfB5em7OKHtAhBpotdp5/WWy/DKDafR0/FZJJMGBrPG20LRnMiAk4DmWitIyISJifz9Op6oOoWMvLEAuNMxOkhcycp2SDyvrS8S7g4NPrMkeDmU9q7ZkfHUSddIP4ZAILEdXin54RDR1ur0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anVRSHoxa21BY25JR0FmK2F2R09pRVhDc3pIbmlibEdRRXB1TVNvMG9rWUho?=
 =?utf-8?B?eDd6QzVpWmJoSkFXOGsvdVdmeXFxSS81cnNsZ3dvY1dHMDhJNEpKa2MyMlRp?=
 =?utf-8?B?eTJma2FuTlZNRlFxLy9qTTlTNFlTVTNoMWVvbTBFaDROOTkrOVpvYUJ0aGhO?=
 =?utf-8?B?SEkyYzVab0RJSjREUTlIUVc1SEFvTndwU2ZwK3VoVGdpak5XbC9US1pRTUpK?=
 =?utf-8?B?bUpweEZYNGQ4T2FuZmlFbmtXWHVvakYzYWVteVhSQlQ2SXBoblZ6b09DMVF4?=
 =?utf-8?B?aGVjRWJyTXo2WWhaTlVYeTJoUUI3c0Erc3JkMjhkNG9uVzdQOWNqRUpGVlVh?=
 =?utf-8?B?aHJpd2RBRUJPTEhOMm90RitpVUxSZkdGQWc2cnNYZnRxTnpYNVN2bmEzYldZ?=
 =?utf-8?B?U0tKTjBHaWF2OW1pSUxRakFMK0FTWElPUjJCWUpXTlU2SUJuUEpJMno2Tm5T?=
 =?utf-8?B?N2dLQXJiOFZtRWJnVTVidXFyNFpUdjU1V0g1Q3ZpM243K3hwUVg4ZDVBQm5O?=
 =?utf-8?B?cTQwQkV1ZlBDSHVSdTkzeS82b1lxVVBmUGdMMWx4ZExiODFUclE0YzluMSth?=
 =?utf-8?B?WlcrS0VZemowK29wLzFwUWhhRCs2QTVPSFo2WnFNUzF6Mk8rWXdzMkQwbGlP?=
 =?utf-8?B?RDVPYmtLK1J3WWpYRFdzNERLalhaRFk3T0JKRGlBVDRzU1crV1JkbkkzVHBk?=
 =?utf-8?B?TmxNbmJmMEI1QnVpMURQTE5mTHJad25Ub09nWnhnN1Y3ZmZobkw3L2RwK29W?=
 =?utf-8?B?UlEybHFPT0FMT29mWm5SQ0NSU2ZrcE9pUXhvQjhzbGRHQXF0dllobUVKWmNR?=
 =?utf-8?B?ckYxK2tpQWxEcG43WGNxRHJaTHFubm0vR1ZrZHNMdVVBMVYzUjNHd2NqVXJD?=
 =?utf-8?B?cUZyVDBHYUtHM01yK2tZaFFjODBrdGR4eGhRUjhFMElSR3BGUUM3YStMMzlV?=
 =?utf-8?B?V2FYbGhsM3FSaFBseU1QRmM4ZUdmRVlDc3hpMkNHU3lMajAvakM0NG1reCs3?=
 =?utf-8?B?NTZJVUdkbkg1YjJHb3pUUEY4c2ZrWHRYd1RHZVlqNkVKclluYXgwOGo2dlZG?=
 =?utf-8?B?V2tDeUhjYVF3dmxRSGNsclBGZ1ZVTEdMOXZ2ejdxREU0TWJWaTFHaVJvTUMr?=
 =?utf-8?B?QWttbU1mYjBnY0xuSGpQQnZTQXBDa3pmNlBWZStrMkx1aDZROVg0WGpFSFlL?=
 =?utf-8?B?bXd6RllDd2xhcGFEWkw5bjBkdEJHcFoxdXV5eDhFREZvbVRCSE1jMG8rbDhr?=
 =?utf-8?B?djJKZFdmS1hKcnZlTjY3ZEZYN1Fway9Zak52SnhmM3FYbHN6SkJBcVB4c2lL?=
 =?utf-8?B?UDBvUzRFYVM1MHdOZVNiYmpXZUdKYmNFQ2FyVEFYUkdWM0hjOW1LRkFrVmsz?=
 =?utf-8?B?VU51dHJiVVAzM0R4VWcrVml3b0dMN2lpR3BxWmk0S201VVJMaXV5UXhwTWdp?=
 =?utf-8?B?MjdHUmNuWVVVczVuYTVMVlFlUmFMZXVGQ2NycUVZd1VkSTN5RHRYUjhFRkFm?=
 =?utf-8?B?UGYrTitjQ0VaZTFpS2tlTzNHdUMyVERReVVKdjZRRzEvUGtoc1J4bHlFMUQw?=
 =?utf-8?B?L1VqblA4SHRCZ1hzYkNSVFZpK0xIYmk1NksxRlJWTE1yZ0s4VUdLQng4ZGds?=
 =?utf-8?B?NkcwVE9HdmozVU85MFNLdzRBQWY0bElPRjY2eFpmbjMzOG5LUk1ENHd4ek5i?=
 =?utf-8?B?Tm9LS2J3SVptVFFpeHNqQjVNR0RscVlrT2g1TTJ4SjFHRUZnZ3grb1RYaUd5?=
 =?utf-8?B?a0Vsa1JTTlhFSGMzTU40M3lHWSsvMHVRMHNIbXB0dGtaZFdqVnRwRDRITnZU?=
 =?utf-8?B?U3dzai85UG5RMFFvUFhEamtzNE8xNlVoSnRNMHFFbGpkSnl0ZFBGSGhQaHgy?=
 =?utf-8?B?TEpNaS9GTFhPRXByWVV4eld6ajBwUWVwcFdyY2taUUxmS3VxYTJOQkw1RzFH?=
 =?utf-8?B?R3hwbVdFSE5rMmprRm1FU216QXVpdm12SFB3ZVBDRmE3MGJENmVLUG1YYXQ4?=
 =?utf-8?B?eC9nd1FDZUdUZVhuSDhaSlZiQ1JMZHc5MTlDTkNqdnNBZVorVUtQMVBjL25L?=
 =?utf-8?B?VnRPclVFa3VvQXdHSUswZGs1d3EvL2RpeU9zbXVDS1NhUmU0a0JHYmNNSDVl?=
 =?utf-8?B?bTVWcnVhNE9vdFdadDdjQUJrcGsyb2pWTG9ZVkpXNTE3eWhCc3JydVZVYTdm?=
 =?utf-8?B?SDkxM2dZYkZETWJBa3VVUzlGanVRWW5OVTgwWk54NHBaZ2tPaG16ZCsveERw?=
 =?utf-8?B?enhIWFBBa2xuRG1RdDBmTlVjY3ljUWk0OXJDeGNTNHpXSGI2UlBNQUp2R1NZ?=
 =?utf-8?B?VFNYY1VMYkd2eVpRNnh3R2xSbkNnS3FQaTJRVkFBSzVZZ1VIZ3pjTjRsdDI3?=
 =?utf-8?Q?cuMUTsLtpQ+iyA4g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F479AC6FF189347A5C948A4348876ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mcZT178ERsYHWtIsyBFeoGx8HmvNu0vgb1y1/jsu9ZU3gb5EPMWneWCW54xiqwlbbp0fyYSeennnxe6XO921cl4Aq1SarRxnvtGiKc9A7gxze03mDbVrpXf9FyYTBs+IIG/ymZImFoEvCvzJMmyTV9PkoxLLdDS0Q8nNSxqNYwrL+c+StvHvYUF12+xEn36yqdxGWr9NMw8qqDr0ylYl88rNmhwoculOdcdV0uNa3wzx08mTOqwsuHe63QZD+pdkCEJBMp8GUch9FcMtVjw9izeJYVzk93VPGb1O4wRIprwtoJf2An6yK+Qeywt+VZbH5B3Dp+tG1QXdk2V/8uY/jQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a4cc54-1ca9-4ec5-6ae2-08de90da3336
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 17:06:36.9283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibc+XTpJ/4u4yUw4gXeINVPz13qY8eCuzPe3A/NOCdYVhzBYhZwAoigOcEVI8oY50rTiIYYHJfxjAK/YRIioIDooDzvrixkVRf38RdD4R5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6785
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTA0LTAyIGF0IDA4OjE4ICswMDAwLCBSZXNoZXRvdmEsIEVsZW5hIHdyb3Rl
Og0KPiA+IE9oLCBJIHdhcyBqdXN0IHdvbmRlcmluZyBpZiB3ZSBjb3VsZCBqdXN0IHplcm8gdGhl
IHBhZ2Ugb24gYWNjZXB0DQo+ID4gZmFpbHVyZSBmb3IgdGhlIGNhc2Ugb2YgYWxyZWFkeSBhY2Nl
cHRlZC4gSGFuZGxlIHRoZSBpc3N1ZQ0KPiA+IGludGVybmFsbHkNCj4gPiBhbmQgYWN0dWFsbHkg
Z28gYmFjayB0byBzb21ldGhpbmcgbGlrZSBwYXRjaCAxLiBXaWxsIGl0IHdvcmsgZm9yDQo+ID4g
U05QPw0KPiANCj4gSSBkb24ndCBrbm93IGFib3V0IFNOUCwgYnV0IGlmIHlvdSBhcmUgcHJvcG9z
aW5nIHRvIHplcm8gdGhlIHBhZ2Ugb24NCj4gZG91YmxlIGFjY2VwdGFuY2UsIHRoaXMgaXMgbm90
IGdyZWF0IGZyb20gc2VjdXJpdHkgcG92Lg0KDQpBY2NlcHQgZG9lcyB6ZXJvIHRoZSBtZW1vcnkg
YWxyZWFkeS4gU28gdGhlIGd1ZXN0IHNpZGUgb3BlcmF0aW9uIGlzDQpkb2luZyBhbiBvcGVyYXRp
b24gdGhhdCBzYXlzICJtYWtlIHRoaXMgbWVtb3J5IHVzYWJsZSBpbiBhbiBrbm93biBzdGF0ZQ0K
b2YgemVyb3MiLiBBbmQgdGhlIG9wZXJhdGlvbiBjb21wbGllcy4gV2hhdCBpcyB0aGUgZGlmZmVy
ZW5jZT8NCg0KPiAgSXQgY3JlYXRlcyBhDQo+IHByZWRpY3RhYmxlIGJlaGF2aW91ciBwcmltaXRp
dmUgZm9yIHRoZSBob3N0IHRvIHplcm8gYW55IGRhdGEgaW5zaWRlDQo+IHRoZSBjb25maWRlbnRp
YWwgZ3Vlc3QgYW5kIGl0IGNhbiBiZSBtaXN1c2VkICh0aGluayBvZiB6ZXJvaW5nIG91dCBhDQo+
IHBhZ2UgY29udGFpbmluZyBhIGNyeXB0b2dyYXBoaWMga2V5KS4NCg0KSWYgdGhlIGhvc3QgY2Fu
IHRyaWdnZXIgYW4gYWNjZXB0IHNvbWVob3cgaW4gdGhlIGd1ZXN0ICh2aWEgc29tZXRoaW5nDQps
aWtlIHRoaXMgb3Igb3RoZXIgaXNzdWUpLCB0aGVuIHRoZSBob3N0IGNhbiBhbHNvIHJlbW92ZSwg
dGhlbiBBVUcgdGhlDQpwYWdlIGZyb20gdGhlIFMtRVBULiBUaGlzIHdpbGwgcmVzdWx0IGluIGEg
bm9ybWFsIGFjY2VwdCB3aGljaCBhbHNvDQp6ZXJvcyB0aGUgcGFnZS4NCg0KU28gdGhlIHBhcnQg
YWJvdXQgd2hldGhlciBhIHRyaWdnZXJlZCBhY2NlcHQgc3VjY2VlZHMgb3IgcmV0dXJucyBhbg0K
YWxyZWFkeSBhY2NlcHRlZCBlcnJvciBpcyBhbHJlYWR5IHVuZGVyIHRoZSBjb250cm9sIG9mIHRo
ZSBob3N0LiBJLmUuLA0KaWYgd2UgZG9uJ3QgaGF2ZSB0aGUgemVyb2luZyBiZWhhdmlvciwgdGhl
IGhvc3QgY2FuIGFscmVhZHkgY2F1c2UgdGhlDQpwYWdlIHRvIGdldCB6ZXJvZWQuIFNvIEkgZG9u
J3QgdGhpbmsgYW55dGhpbmcgaXMgcmVncmVzc2VkLiBCb3RoIGNvbWUNCmRvd24gdG8gaG93IGNh
cmVmdWwgdGhlIGd1ZXN0IGlzIGFib3V0IHdoYXQgaXQgYWNjZXB0cy4NCg==
