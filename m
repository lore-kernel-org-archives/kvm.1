Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3607B36214F;
	Thu, 19 Mar 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948798; cv=fail; b=p5qFKhnAZIYAM6psFWiYw7D6hLGToQHqzG1/EWD8nxKZzt3GMc9E5Eb6hMZKWn2WJVqGRP746OAOKlXd9v67le3dCzwEDSfqv7YPIBBLQzRNqv8LxV9b1k6RiBcJcVVrHwR3c5xW4DCLJGDHVlC0n3wwRZ27EqpojSBCAT/JSCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948798; c=relaxed/simple;
	bh=0BO79SGZCoO6A6wrXQMKYzYZD/xZzM9UxdsMWyE/5MU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIyc8QKAmL0Ir3+KUvsfKrfMgGyLaqv6w3fqRx78PuFLIUMawtNM4lOA2jauRqpfgODu652zSiXsSh3Dcm3JEJ1hyuEy9VnQsRKAIJCg4MN+KVaNcV/Ifj+YckJdRl/c4pHSLWGPWoH4BgPFuQ+uMVT0ANkSA/xVFyqz97DfFjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvwpfBrw; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvwpfBrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773948797; x=1805484797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0BO79SGZCoO6A6wrXQMKYzYZD/xZzM9UxdsMWyE/5MU=;
  b=NvwpfBrwAyolORT16EqU6b5rVWP6wU9GiLQ4TDYNs/fftIMVTtVcheUb
   IBmNegmn71Bqy6LuiFpFvUYdEqS8K4GT4Dq4YSn91wDUNLLIfQnjp6L43
   5K011QPZjtjzUIf9hMClhGhvSk1o/RNX5YfCurcbuGkbulAvIVlv/iwF6
   bu7Ktmd+if7ew/l9wuWHeWLOX1ZtDRPllNrJ+9vN3Nu3/62YqurMbiHZL
   4RnrooFG4vj5X72kOzkX2D0mSc5wGmSdu34XB/A4ydEPYXF9BUMRtF5VO
   22JvHJ7UI5fngtU8bKAXlM/bC+e+iOm+0l1GRR09MgHOwZBViOxVYYJ0I
   w==;
X-CSE-ConnectionGUID: f7U3npSKQ/2USRlvftc2sA==
X-CSE-MsgGUID: VcG4CpfDSI+diHdSV6SkiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="62597973"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="62597973"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 12:33:16 -0700
X-CSE-ConnectionGUID: aZzlwFieSTCt9tKEZdsWlg==
X-CSE-MsgGUID: Ng+dFHn9QWmxr6tJmHmlQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="225035825"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 12:33:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 12:33:15 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 12:33:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 12:33:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH6F35Mf7qssr5KCEJFl8SznydkZYHrmmIlxTKoyfs17QvCVEX7yooEOe1msJiW+n4UWDiFEYN1gugjl+89S1A18ySa4zPooKyDSO5aFJJZDAReBOclzKuGZ1yWxArnVevevNnOR9QjSmPmaaW8tZDrgF2ZbG2tkVMZmOXwxVz200JwTphOksCIYkbA412qIu6KRxfV1ur0/AzjfQjmyINWk3G8BwsrOvaoHppqXbkAAKCaI8mECgqweXTZJhkXidLGGMs17k3ofzwHQ0gnX8dhWCgt+aDUB/X7OjNHQbvlaslMohKywZG1g1ii2WX/qjJEprLog0xA2SnCSy7cTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BO79SGZCoO6A6wrXQMKYzYZD/xZzM9UxdsMWyE/5MU=;
 b=UcF1XrJjX8ZBuVooMNgV/PR7KgzczOpEbtwQEWEc6Ce04puIrfUUk9aL7T3NjbvS1lvDhk/diAk6hnrmQv7WM8ZKD4QsRwvS/GPVL6CqBnLVEs04kLOZE3Xa7P1ec4+2RyswlvvowsxZzVvyWeQpfuW/+BA0VbTInncZ2tP6M9/Mdc/X3qS6zWFxzYDMfnTIU3YB35rQvqx6wV4+UeDohTo7/FekRfEAUsovsLa0HXJRyCfCL621namMJMRwy5IlnoqI9b73vmOM005FGgFRb9nKeIreYKtYMze4mPP+zUdW9qvh+n/liK2Y7DiHVSCS9IaStnH67ZQjniluWovUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA4PR11MB8964.namprd11.prod.outlook.com (2603:10b6:208:56f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Thu, 19 Mar
 2026 19:33:12 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::3ad:5845:3ab9:5b65%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 19:33:11 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dmaluka@chromium.org" <dmaluka@chromium.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "Yamahata, Isaku"
	<isaku.yamahata@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
Thread-Topic: [PATCH] KVM: TDX: Fix APIC MSR ranges in tdx_has_emulated_msr()
Thread-Index: AQHctwnFo9ayO2gQokudL8i/bTewfbW0sMWAgABcswCAAAmDAIAAYmaAgADG/IA=
Date: Thu, 19 Mar 2026 19:33:11 +0000
Message-ID: <f67179d7050ae28ac261bb6227b1c045c10579c9.camel@intel.com>
References: <20260318190111.1041924-1-dmaluka@chromium.org>
	 <94b06319-2be8-4f01-87d1-8989ae1ca85d@intel.com>
	 <cb99e44c-8bc9-4bab-b485-9f63a4d0b262@linux.intel.com>
	 <93358559-5ed1-4574-8951-24d7ea9354e4@intel.com>
	 <ee8d7ea3-0ece-43cf-ab07-6954df4c01ad@linux.intel.com>
In-Reply-To: <ee8d7ea3-0ece-43cf-ab07-6954df4c01ad@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA4PR11MB8964:EE_
x-ms-office365-filtering-correlation-id: df775783-0b10-4268-ee33-08de85ee5b8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: MMh5H4rjsSm1MePk4fZFY1SpTGEBEAsksr1EtrnlzyKb7QflZvxJ7rLqVl8sgwKlAXreitgiFazbVOq9uQQCkiozEFPMEt5p9u5uheG4AdbksqMJnSZ+NIG3M9rDVeRKw8QjUH5+32QPAj63phd5EGZfhjCAxkWEwzydFXqKtxDUdbz1pvFOTiAyHhFCVEXWIeQYsy4xExZFZYZ9jrncsNgr5CUUQHGC2Nmfnx066nxFFonUwNczhZ8Ys1vtCWnDR369l/pFvMpYFlfSvr760vkW2rjL6Zb3B+IUbSOQ8UJRcdolHH8z/U8CTG3eBR94AMRawWJvzw/tuaZh+E9KzN6NpJ7wZ7ofrmvhTPljHUR7W5QYgCXxzqX8OXFBHYbLjkSL986ILf7ovVrmeXOhtJF9iJbGtb8lxMhZsI1EMJQWTYMw417Gd7VAF3MeP65rETVFV3llLWLJRx1+GBgeMGP4YoVpjkS0d+ozZPjTD47bzpdGgUtxqWdy2yAwT7hPUd4I4cOUefmnx9uEXZhUucC8VdA1Kuq3bL9jpQBk7lP0xPae2CImRdHDi/dYHxk1pGB0aw+HxO4IjZg1sIztt2iCJhOvd1ZP9RXjQKOKgMfIj1ef0qyFHbr3cSQdRi9k56sz+R7C7rc/+guY27Flsu88bl5kKTs4O1B6gZ2enSheIA0Drx3sh95XDJhPkTASCKr6oPVZm4KWK6Q6VLGxaBOoIbLhGEdIneXwcFECqoJTM7oTNCX31DYgbYWOOIIj4C4Keb5XFL0rjqU8G/VmsrKacKmrQuD3tj3JBw+hWgg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlRrQ29GY2lTNTFUckIwV041eXlnRnJoby9Md2ExZit6SlpIVTVMQnJNQWNL?=
 =?utf-8?B?T2U4QnpTMGpYWlE4SUlNZTR5ZWJGOTVuTTlqeUdXajdRYVZxWERic25rTFJD?=
 =?utf-8?B?UHlZS1ZVOE12bGpscDFHRWFKUFk2SFI3MmVYMys0eG14bFh3RTcxZi9GOVc0?=
 =?utf-8?B?ODJ6cmR6Njl3RTRwVWFTZFJPdlVtbVRpamhxVjlaanpjemxSQlZmTW5YK2dD?=
 =?utf-8?B?VFYzRWl1UlpUSlRIK09xTlp5cWhycGNQNXNuZ3IwWVQ1WkRodk5LbHFSZnI3?=
 =?utf-8?B?K08zYS9HUWNCQ0xBNnFSZkhibEgrZXl4WEk4SUsvMzIzUkx1aXZUQm5CenVV?=
 =?utf-8?B?bFQ2Q0tRZFFZR3N5bHZLajBXQnM1bk96OUdINTB4ZG9zQmFBMGpvT0lLTWhN?=
 =?utf-8?B?c2xmSktIUklYU0lKcXhaRDdwdDBNd3B5MFBvbmcwMDlhQTV0cGNZaFZFNEVB?=
 =?utf-8?B?M3FQb1RGRktBYW9zaEFNL3Z3cGtEOVhBYXlzcTN4blhFNlNuaTZqV3Bubk9P?=
 =?utf-8?B?SHVkT093WDNkeFdiamFOUkpvd1hIdTVIS2JYNk45YWE4b1lLVGtEOXdMME43?=
 =?utf-8?B?d3hhK1BKWjJOWE9lVC9sZUhmbVkyVk1vSDFNTzAvSTd3L052WGtjalVlaWRt?=
 =?utf-8?B?bnByNVYzaVY5SWVnNUV6NVdrRFRJRFBwV291bUZCV2NSMDhNeUJBZlJmekll?=
 =?utf-8?B?UTJnUmZ1elVHRGp3WGEwbXExZWlzQWxET2VhRy9TUjJmKzhEUnhhQVkrMzVV?=
 =?utf-8?B?RnVoY1NJZmhaNUppcm9BT0p6K2lPUW9SL2w0NW92VjZobXU5eC9Pazk2QkNT?=
 =?utf-8?B?WmFBemV4RndERWRMcHE0S3pnM0dDTWRFcEt1T3orazZMdUVNZCtOOGt4eWRG?=
 =?utf-8?B?SlNqZXZiVVNtTWd5clMxMjEvT0M0SEQ5aGIwTXFwVnBBOXF0cEo2RUJsU3FJ?=
 =?utf-8?B?YlV1amJEOXZRTm5Fb2pGSjhzY2U4WGQ3YVlXQUgrZ1hoV0wzUW1QSFMrcFlt?=
 =?utf-8?B?YkRqak9VK0V0VGR2akxsZUdhd05uQjZ3Znk5OXllUDVRMDM0NFlnM0o5b2hN?=
 =?utf-8?B?U3NSeGtNN1pHVks0Tlc0LzFjZmRxa1Y5bjdXZW5mUFJab0YwaGlMYXY4NGI2?=
 =?utf-8?B?dWZvMkV1eDN6WEtNQmhXTGhESmo0d2ZKZHJxR2hONFlDZFlNWUwyejRpdkhr?=
 =?utf-8?B?NkZVTzZZMmNLelF4MExmb2NQMktZVml2SjlqSWhrNkdzUXhwNlBvSEJIY2ZR?=
 =?utf-8?B?N0RCSEdSVC9XY1lZemxCK0kxc3lobTJsck52dzdHRFloWWFvS0tUMGZZNnBo?=
 =?utf-8?B?Y1hKVVc0aXZ4QkNsS0Q1NHViTlFQbXpvZ2ZlNy9LWVl5YjgrRTlNVzVvMGIw?=
 =?utf-8?B?eDhlRDNNYWQ5TndJRVhBTHg1eEpMUXZKcXB4TDBOVHgyWVpCZ3hqaVpBVENJ?=
 =?utf-8?B?SEZaVG5NRnh5bnY5YkxvUzVWWmlqQ2dhOW9TOWNJeWdjVGRkYXZCdE9oRmFO?=
 =?utf-8?B?a0V0Sk5xZmZkMzV6b0RuNjZFOVFRSXphM2RMZkpLRzdndDViczBqRnFXM0lO?=
 =?utf-8?B?NWk3OVBKMDR4dC9pL2VCc3d1TzcvSlBGdU96U2ZmNkswZkxDVk9rKzNnTEw0?=
 =?utf-8?B?RHZ6cEpOUGpIb1BkNjVPditUT2dDaDF3TzhZa2kxVy81bHRLZk4yUDl3ZUp6?=
 =?utf-8?B?WU9sb3J6ZnovSTVlZjNWTXU2cTBidjByQjFNRkFrZFk2VDdBZUF0VnhkQ3kx?=
 =?utf-8?B?S0hKNEJ3eDRNTGVnb3Z1anVDeGlUSVZjaVVHd28zVzg3YjJpdEdaTzlCMG9B?=
 =?utf-8?B?bzFHcTlMWjJXRHBURlhIeVJGZE4vM25qM2JaWEhGa2x6aHhjZ0l4MUdQc0VL?=
 =?utf-8?B?VHFlaEpNaVI5aEFsNDhySW4yMnFNaEU5T3pkNm1ob01nRzdFUWFydkRzV0RX?=
 =?utf-8?B?T2NMSm40dVBTUEpqdmlRejcvZDR6TCtTQ1Ric1R5U1dncm5DS2djOEo0dTds?=
 =?utf-8?B?YmdsOWhVbnJHa0h2WVRKRGxERFFvcjNoUDB2YzVIRFg0d2VLVHhSdXVld0RG?=
 =?utf-8?B?amdtQmcrWHBKVzJydXlHcFhMZWxLWTJyMFZiZVIvWGdxN3hobXFFTnJjc3JF?=
 =?utf-8?B?b1U5d2hkLytrNjIzbnUySHN1aGRGSTlJUFlBeCs2elBDMDg5elZXdkxTSHZa?=
 =?utf-8?B?dkFVSGdicCs4emRTV3Yya0NnTVhnQ1hWQ0dEdVJjcFpUbm0xYktVVUVCalVm?=
 =?utf-8?B?SnJBVmM3amJScjNLK0x5aHJCTDBrb2dPYU1ORm00VkFRRUVGajNNQit3NHJ6?=
 =?utf-8?B?cHM2TXpVRlZha2lGVmR3R052ZXlDYkhwVFR6dG9Nek5hTlNqNkFCYlRqODJS?=
 =?utf-8?Q?1x4he/s1ZtmDd5xU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24C9D6619E028B4B86D6C3914A99CE0B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cBtdWi9VdipTMPmgd75ntlLybtZ+MDuEYdLTgcnaZi70UWcPdGCaIarNEX+LVphqUMFrzQtr2/aaeur7X3fVkuHltgFS6S26BbxB1wOTUWOBLpKOsLm2zHy+sysXe41t98Ht4NmmmtQ8oLz5UsoJlPZYQ6rfQU7XJxCygSByOt4pwJoSEVTne1Aezcoa773hdouhTYPRgzWLDxbMyNqqBzdo0Gc8+kkwNIC83lXvYk+RCV8ZashCEGrjukSlr/8hbiBtgU5HzFdekzp6Dg07vyUjMPttyPLpOluljzzezFz/rX1i5RoB8nWrBPGgLDh5/bhwSDSTnVjo9TAXOCNSHQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df775783-0b10-4268-ee33-08de85ee5b8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 19:33:11.7872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBzLeKENpvdhb6hSzsoAt5qyLO1EvqCPpL3WMZi4UMQGnTGIUIJLpbZ78SUwdtHLPlhZzMXmXZx9T/JR1tRYFyhFtuzcVE7n0bkp88xKjek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8964
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI2LTAzLTE5IGF0IDE1OjQwICswODAwLCBCaW5iaW4gV3Ugd3JvdGU6DQo+IHRk
eF9oYXNfZW11bGF0ZWRfbXNyKCkgaXMgdXNlZCBieSBLVk0gdG8gZGVjaWRlIHdoZXRoZXIgdG8g
ZW11bGF0ZSBhIE1TUiBhY2Nlc3MgZnJvbSB0aGUNCj4gVERWTUNBTEwgb3IganVzdCByZXR1cm4g
dGhlIGVycm9yIGNvZGUuDQo+IA0KPiBEdXJpbmcgYW4gb2ZmLWxpc3QgZGlzY3Vzc2lvbiwgUmlj
ayBub3RlZCB0aGF0ICNWRSByZWR1Y3Rpb24gY291bGQgY2hhbmdlIHRoZSBiZWhhdmlvciBvZg0K
PiBhY2Nlc3NpbmcgYW4gTVNSIChlLmcuLCBmcm9tICNWRSB0byAjR1Agb3IgdG8gYmUgdmlydHVh
bGl6ZWQgYnkgdGhlIFREWCBtb2R1bGUpIHdpdGhvdXQNCj4gS1ZNIGtub3dpbmcuQmVjYXVzZSBL
Vk0gbGFja3MgdGhlIGZ1bGwgY29udGV4dCB0byBwZXJmZWN0bHkgZGVjaWRlIGlmIGFuIE1TUiBz
aG91bGQgYmUNCj4gZW11bGF0ZWQsIHRoZSBxdWVzdGlvbiB3YXMgcmFpc2VkOiBDYW4gd2UganVz
dCBkZWxldGUgdGR4X2hhc19lbXVsYXRlZF9tc3IoKSBlbnRpcmVseT8NCj4gDQo+IEhvd2V2ZXIs
IHRoZXNlIG5hdGl2ZSB0eXBlIHgyYXBpYyBNU1JzIGFyZSBhIHNwZWNpYWwgY2FzZS4gU2luY2Ug
dGhlIFREWCBtb2R1bGUgb3ducyB0aGUNCj4gQVBJQ3YgcGFnZSwgS1ZNIGNhbm5vdCBlbXVsYXRl
IHRoZXNlIE1TUnMuIElmIHdlIHJlbW92ZSB0ZHhfaGFzX2VtdWxhdGVkX21zcigpLCBhIGd1ZXN0
DQo+IGRpcmVjdGx5IGlzc3VpbmcgVERWTUNBTExzIGZvciB0aGVzZSBuYXRpdmUgdHlwZSB4MmFw
aWMgTVNScyB3aWxsIHRyaWdnZXIgYSBzaWxlbnQgZmFpbHVyZSwNCj4gZXZlbiB0aG91Z2ggdGhp
cyBpcyB0aGUgZ3Vlc3QncyBmYXVsdC4NCj4gDQo+IEl0IGNvbWVzIGRvd24gdG8gYSB0cmFkZW9m
Zi4gU2hvdWxkIHdlIHByaW9yaXRpemUgY29kZSBzaW1wbGljaXR5IGJ5IGRyb3BwaW5nIHRoZSBm
dW5jdGlvbiwNCj4gb3Iga2VlcCBpdCB0byBleHBsaWNpdGx5IGNhdGNoIHRoaXMgbWlzYmVoYXZp
bmcgZ3Vlc3QgY29ybmVyIGNhc2U/DQoNCkkgdGhpbmsgZnJvbSBLVk0ncyBwZXJzcGVjdGl2ZSBp
dCBkb2Vzbid0IHdhbnQgdG8gaGVscCB0aGUgZ3Vlc3QgYmVoYXZlDQpjb3JyZWN0bHkuIFNvIHdl
IGNhbiBpZ25vcmUgdGhhdCBJIHRoaW5rLiBCdXQgaXQgZG9lcyByZWFsbHkgY2FyZSB0byBub3Qg
ZGVmaW5lDQphbnkgc3BlY2lmaWMgZ3Vlc3QgQUJJIHRoYXQgaXQgaGFzIHRvIG1haW50YWluLiBT
byB0ZHhfaGFzX2VtdWxhdGVkX21zcigpIGhhcw0Kc29tZSB2YWx1ZSB0aGVyZS7CoEFuZCBldmVu
IG1vcmUsIGl0IHdhbnRzIHRvIG5vdCBhbGxvdyB0aGUgZ3Vlc3QgdG8gaHVydCB0aGUNCmhvc3Qu
DQoNCk9uIHRoZSBsYXR0ZXIgcG9pbnQsIGFub3RoZXIgcHJvYmxlbSB3aXRoIGRlbGV0aW5nIHRk
eF9oYXNfZW11bGF0ZWRfbXNyKCkgaXMgdGhlDQpjdXJyZW50IGNvZGUgcGF0aCBza2lwcyB0aGUg
Y2hlY2tzIGRvbmUgaW4gdGhlIG90aGVyIE1TUiBwYXRocy4gU28gd2Ugd291bGQgbmVlZA0KdG8g
Y2FsbCBzb21lIGFwcHJvcHJpYXRlIGhpZ2hlciB1cCBNU1IgaGVscGVyIHRvIHByb3RlY3QgdGhl
IGhvc3Q/IEFuZCB0aGF0DQp3YWRlcyBpbnRvIHRoZSBDUFVJRCBiaXQgY29uc2lzdGVuY3kgaXNz
dWVzLg0KDQpTbyBtYXliZS4uLiBjb3VsZCB3ZSBkbyBhIG1vcmUgbGltaXRlZCB2ZXJzaW9uIG9m
IHRoZSBkZWxldGlvbiB3aGVyZSB3ZSBhbGxvdw0KYWxsIHRoZSBBUElDIE1TUnMgdGhyb3VnaD8g
V2UnZCBoYXZlIHRvIGNoZWNrIHRoYXQgaXQgd29uJ3QgY2F1c2UgcHJvYmxlbXMuDQoNCkZhaWxp
bmcgdGhhdCwgd2Ugc2hvdWxkIG1heWJlIGp1c3QgZXhwbGljaXRseSBsaXN0IHRoZSBvbmVzIFRE
WCBzdXBwb3J0cyByYXRoZXINCnRoYW4gdGhlIGN1cnJlbnQgd2F5IHdlIGRlZmluZSB0aGUgQVBJ
QyBvbmVzLiBBcyB5b3UgbWVudGlvbiBiZWxvdywgaXQncyBub3QNCmNvcnJlY3QgaW4gb3RoZXIg
d2F5cyB0b28gc28gaXQgY291bGQgYmUgbW9yZSByb2J1c3QuDQoNCj4gDQo+IA0KPiBCVFcsIGJl
c2lkZXMgdGhlIGJ1ZyBkZXNjcmliZWQgYnkgdGhpcyBwYXRjaCwgYWNjb3JkaW5nIHRvIHRoZSBs
YXRlc3QgcHVibGlzaGVkIFREWCBtb2R1bGUNCj4gQUJJIHRhYmxlLCBNU1IgSUEzMl9YMkFQSUNf
U0VMRl9JUEkgaXMgbmF0aXZlIHR5cGUsIGJ1dCBub3QgaW5jbHVkZWQgaW4gdGhlIGxpc3QuDQo+
IFRoZXJlIGFyZSBzb21lIE1TUnMsIHdoaWNoIGFyZSByZXNlcnZlZCBmb3IgeEFQSUMgTVNSLCBu
b3QgaW5jbHVkZWQgaW4gdGhlIGxpc3QsIGJ1dCB0aGV5DQo+IGNhbiBiZSBjb3ZlcmVkIGJ5IHRo
ZSBLVk0gY29tbW9uIGNvZGUuDQoNCg==
