Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602ED2E2DDD;
	Wed, 25 Mar 2026 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774412995; cv=fail; b=sZGy+qugPxaMNJOCqIEMNaET6VOI32Iy/VyInUiNAze77K8PqJvuxijOsZKYEYdDA7UZKPumnbnkdwO4xKgSKvFi0XowktxTh0+PKpC35k4OL62nIm1zSd82hTb6z0+rD3Pd3PN4Yvt7C3PREuX/MRvTV+iyJQ/JKYfSMMlkh10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774412995; c=relaxed/simple;
	bh=tAklI/7/OvdjBZZIJA67gSWO6fVZRMJS1g1SUkhyT9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g2o32RRvfqrIpoyxw7QPTBluM6OzigWgWCXdVIpnoEDvi3/ouxuHjlTQRzjkaXUX2e8+qbiXDdo6KGq3ILpMDW7vkmFP04zsWwA9dYrgJJZk3Yv/9yi+rBxfFlyU9UO4zXdey/vP1rRAbELXzteIvKmFiNR6HbfxKbXlTDW/bcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxXYuHcW; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxXYuHcW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774412993; x=1805948993;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tAklI/7/OvdjBZZIJA67gSWO6fVZRMJS1g1SUkhyT9A=;
  b=gxXYuHcWscx+lemWm0rYRLuu/GAFOwXM0AzocHbA17jXnFvOVE+6xK8n
   vmmvo7XS2l8RmL+FAdS4+WdTZeHjoYPgkA8Mgd17PhY6fz8qsp+sYPay3
   kJNjn3vxlHVpMpaLvMhF/iIP7nwC/FWgC3JePXXwyQZxOhJXQwaSv8pmR
   zmn0+1bzRLY/Eos4nZqTHnHBLa2GElxNkUiugxwXKqzZPBuiK1s1emtZ0
   EdQrHiRxhE3UC+faxL0sR/ZSEstHKu434/oapnDiomdYnFQ08tfM1NhbK
   2T9EaB+J4n0WHEahs1rPf2Krutd4WbpD5Xy+NMqGovr+JyPyelh9Cu2LR
   g==;
X-CSE-ConnectionGUID: yFjBYXzRTqqkPGK2DjYqPQ==
X-CSE-MsgGUID: VWnGRbdtTqeq/i6xcrV1lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="78042730"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="78042730"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:29:53 -0700
X-CSE-ConnectionGUID: FvUBxiBrQB2taQjXIDcpIg==
X-CSE-MsgGUID: o04EO3FJS1y2XnGQEvedCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="247595365"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 21:29:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:29:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 21:29:52 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 21:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XB748v8iKK/RzGpdi2CQxb3c+k4DdK9MNC2HxqioKMb1ZUCiOCunvbOa6fvppDfPteMMuEK57YyJjtg+Lc7YlI7gzWIK60vE/nRYreYNkBxj3AeUG7+3RX8yYxRYqGPrmskI5Sgp/J4XaKphnaHN1me9eygEX3HT+LrWjS67i/Qz4pty++XMcXn+VcmfDA7lJ6/mJ0JmShRd7vTH7haU0vGGa84R/WuPqbm5MEUbUTlLVwDi+RMgXiFTppiQ2ltTjlBmEqbwAFhU+6urqVGG1lflEOa876ma8SRboHjoZAlcgECUYnyA8Ij4vFmW0n9b2IM4K53VGp7z/plkw4eJFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAklI/7/OvdjBZZIJA67gSWO6fVZRMJS1g1SUkhyT9A=;
 b=ZHPmhkHhPqExEqbx6J+wMrHz8fog6hcjRYBVWblXX2lqO1SbXNCtbsree6HSbf1fi+2m6NQ3tjPchNeXkQMayuCIiITpiYEyc2Txitp8HYLzIxIS3T4r66UxiVZBVte2g6PW4oL0egsKtek7/K8wni903Cv1tnOj2ClXlNmH5wcvcsytuTHvfJ7sivVcYctx0zCD+dSn14DLjCugb1rMn7QLF3JlSwFtgloPFPWJVL8V+xA4t3TQJbkqlIpiXdTHcr3yPNQZ75JV9/J54F6/huNm+05KdU5uTqTKGNZYFAlP41Vq20eExLnuIPczcbn85uQZ9tdHrI6dZy+xPReaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 04:29:47 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 04:29:47 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "amit.shah@amd.com" <amit.shah@amd.com>, "Kohler, Jon" <jon@nutanix.com>,
	"seanjc@google.com" <seanjc@google.com>, "mtosatti@redhat.com"
	<mtosatti@redhat.com>, "nikunj@amd.com" <nikunj@amd.com>
Subject: Re: [PATCH 02/22] KVM: x86/mmu: remove SPTE_PERM_MASK
Thread-Topic: [PATCH 02/22] KVM: x86/mmu: remove SPTE_PERM_MASK
Thread-Index: AQHcuMcvvxOqmHTVBUqVENjRvTcPPLW+rnWA
Date: Wed, 25 Mar 2026 04:29:47 +0000
Message-ID: <46976f8121061aee3c0dc4304fbe83efe3e6b5a9.camel@intel.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
	 <20260321000931.1947084-3-pbonzini@redhat.com>
In-Reply-To: <20260321000931.1947084-3-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|PH7PR11MB6498:EE_
x-ms-office365-filtering-correlation-id: 151ab3d2-8a15-4592-3a6a-08de8a2725c0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: ReuEV9m1zHfsgMbjX29RrmD1vMK5bpltQeZfOBOrDscZzjJ5EIS8lOf3XUmPxML5ETxLgwq/5IXuMd/ZZWEgdILC6m0FKHlkTepuo93ajsQq/H60BR1XM/HIsJLIoxygrnfbdSPVKFbSEIs8brfArxNDLpgtmAi4eveYymYyOWNsj19ajFyiXTI4gaI/KkvNNnzzqYZCM6ZCX234ewIvtCSkl9RKupXYkJl8mFl4Wt9utY1/K7TI2aHt+71wyPn3yTxJCgyZw7uL8F9tMX9QCvPEQ0QfE4tSDMZOQbrW9titRn1+E7Sa3KIvF7Hi1Eke/9wXzOa6KZSFH69rXpdaouYoU/C3dYvT4MfE/8YXtAnraBLE6GcR1TmEsEr9Iz/3a+6DGg2BE5Btf7DRlcl5nhYRQJrVeSsFQvJMOCiS2kPGo/YacDBTnipbCOwlO9m/sqTBVRRk6dRJn1CXG4elH+r9wumEfJPIpZSWJdzm1dkbj/pE05YvlNsTuCCDlLGD7dnItPtCYBmvAoRXKA14S1zfCZRE/mRVAknaPZKioy+sbyxn4a1Jh451XISU0XwoJdgHHCyKRQ9a3fRvmJa6KQqpc1tfS1us8dfBtMDeDYLWdIngpEnIFVMhkZX/8CfFOJ3aUUxi6QzSArLcJKHxr5c1maSMZeKRKxHNPsXbJ1ehzQjmvy7iN+iCsUAWciKXTsTHkoGyV3u0qOaMRNiXCUKRGuInxwjITBzMJKJj6bRv7yLVGyKm2K36fL6Ys+roAdEMqF1T8MioVZ8pxSCjAqVWtIwhV69/oR/yNAg2fl4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3hscmlHOXNzdWoza0RKRHpoaVhxWFo4ajQ0a0lSdkFuT1h0dUs4eVVlclk5?=
 =?utf-8?B?OGR2M0hHTXZMcTB3dXIxMnVWZUJ1Yk5TdkNRRWNqWGdZNWRIaDh4Wm93cFZi?=
 =?utf-8?B?RGlIUW1rMUU1ekRkMTZ6Sm1rdUVveDYwVHE5QXRkanprWEVFREtNMVlyMkho?=
 =?utf-8?B?VjN2ekRhWkdMemd6bktMSityVFdienFpd2dtM082THRiV1paVEtZZVpFWmhi?=
 =?utf-8?B?M1kwa1JZMHdmaWpiZERpMFpCa0JKNnplVmdHRDdWSzVVZ1hmSDF3OGtBTGVU?=
 =?utf-8?B?VXJYaDhIWENhRDRnZVMrQVgzYW9aM0hyelJLWGZZcHVpaEJRSFJjU1h6UzRo?=
 =?utf-8?B?N1o2M3FtYnJWYnpyallFWDBmcUxLTFo4N3BWbVF6eGhIenBzUEl1RnZSTDlR?=
 =?utf-8?B?dXZLZlBhajNPczMvQU5Ccm4ydEhYcDBGd09yYWlEKzBTK2hiNGJzQWNJd0Ra?=
 =?utf-8?B?TTFFZjVzVjNUYUs2N0hpTW9xNlByVDh4TldlN0RiSjh2OEgzSFVWZ3lBMXU4?=
 =?utf-8?B?ZWJHaisrMFFVb2NqVHp0YzVLdjd0MnZkSGUzcHgyd01XUmhUVWhwNTNTVzRr?=
 =?utf-8?B?eUxJRWEvZm9ta2FWcVFXMHhCeFpyUjA0WE9UWFFrQ2FiTFZFMytxU1J4c3Qr?=
 =?utf-8?B?c21oQ2lOUjAydFlOOEJjSjAwUFQ2L083RnYwdG5FRDZRYmRncmRZeTRITVVL?=
 =?utf-8?B?YWRkb01hZDV5Z21YTlBYV1NaNUdRQUJRVW5vL3JESy9XN3puRjZmdFg5cUxJ?=
 =?utf-8?B?TFdXN21XaktPN0NZL01YWGdlZjJSTTlRWGx3TEV1TlovNWlhRXQrUHZUS09x?=
 =?utf-8?B?WHNjb2svaGh4Qld2MUtGdExtbFl2cVVJblhqMU9hcFVONXJXeDZBSDZLdDZ1?=
 =?utf-8?B?bUlEUDljNEFjREJkRHRoRjFWc3htcnBaRWFyNGcweVB6UERuTE5vNmh3Kzl6?=
 =?utf-8?B?QzE0aENDaTFtTVlIaFpUbzVpNVMxZnBwVUxSTU44NHpIc0QveUVJVllvQVJQ?=
 =?utf-8?B?VXB3bmNhZC9aRWU3V1IzVmRFREkwbXJ4M3pHcm9GMnppYVg2dmxBaWcwbWYw?=
 =?utf-8?B?TExUNHU2T0ZvOU1HVkIwRTV2b0NHTGFKbVVCSWJTeGhTZExxUERpZUFDRWZR?=
 =?utf-8?B?cHByUHJhVHBhOUVZQnN2YUtBcGJJYUpkczdDVmNZYjJXNE5Md0hrUDBVa3ZP?=
 =?utf-8?B?UUhGcXZCMGhLQWIzL3ZnMm9CNVlVUDdsMlhkaUcxK2pLOFVMa05XUURYYXda?=
 =?utf-8?B?YXcvekRGM3pUL091WXkrdmtjdkdtUUR1TzU1U3QrMVBjeS91Nk1JdEZ5Nkpx?=
 =?utf-8?B?Qyt2TmRIWGtXcVlJT0QyNXJPRHUzRENBLzQrTWpmSis3aVFXUlQraENQWjJV?=
 =?utf-8?B?VWtBL1BuMzZLYXN2NyttUjJZVUxCM1FWZzZ5bWUrM21GWVRXcndJTDRrdXk4?=
 =?utf-8?B?eXdnYlVnVzNZV1FnaWN1UzNjRVJWNkd0aVlHU2QvaFUvTk9DN2tzUlNiTEE0?=
 =?utf-8?B?Y1JVL0k1Yy9kMkxJbklUTVdKcVhKMXNDL0ZhNGIvZDZ0SHZoWWRkT1NzVlJJ?=
 =?utf-8?B?WW1EeVRVeklGbEVQcnhBK2JqMzdFS1AxYTVoVkpsVzhPNnE5Q0pjeHVnYmph?=
 =?utf-8?B?L3FtcHNrK1Z1WUZEaVd5Y09vVTFLZm8yM1piYlFtS0JvZFZXY1JzU3RtdFRK?=
 =?utf-8?B?dFpHR3ZMUkJHb0VKd1VlLzR2UzdXNU5YSUJGSW5seTZLNGZ5UUdneUh2Qklo?=
 =?utf-8?B?MFlBdmw0M0FHOWgyQk9XMkJDVWQ3dzBPUlJOZUJjYU1PeHR4NDh3VVBGeWsy?=
 =?utf-8?B?UFRrcFNwUGFSZTB1TXJsZmxrODBTR3o2M0x2MjBxdXlEUUY0YU5PT1UvOGJS?=
 =?utf-8?B?TTJneGZaNFptalNxT1VCYkpuQ3J4blhjWjd4ZmJySEMwVnRyTU9QOVJreUtW?=
 =?utf-8?B?RlNtUTJVaVo0SjJIY0tEK0prTDREOUlmTUFabEVoSXhiY1BCZXhXYm1WUDFs?=
 =?utf-8?B?WDNGcE1jTUZ3MEpHTTV6T0RrNEVnakd6WThxZ3BlSmRJNkEybnZFMUF4UUVx?=
 =?utf-8?B?NGF3Q1NuSGpSVDhvQ1NUd0F2N2VXNEhVRTYyRTlZUWd3eU1TNzI0WlNjZXdS?=
 =?utf-8?B?MDd4cDZrMFNvQm5jcWsrWkFwYzVqeXdocHBOMmlsS1NSMzhlQzFJUnN4MFhJ?=
 =?utf-8?B?SmZsSW5CYjlmZlhLcUxPM2NIVUUrNEZRZnhOUW5uNlVuclczaElQT29yQXdZ?=
 =?utf-8?B?dkZkSmZENUZnU1MvcnhBUVhtTkczNlJmK2dVMmpTSVA1QXlmUy9tU2hRZUJW?=
 =?utf-8?B?TGFSZHQxaXlpQlR2cVRLWm14OUFhMGdRVVpFa2R6MTdYem42MWVYdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B288B730E815D4F9D23F5C2EFD1325F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: H+4Jj2mfQV4Ok0o93Rg5JgtRdWLZApadMlg1AG7/eFkmwaEGBc0QxCxjMFXOn5hWX9nbc06YfJkrIBiLvUbL/cSwjso/1FSQbaQ+KOI1OCyBjyvevCvucF6EPUKhLPImqR6UeexP3Ep/Xv7kTt/umvom8c1Xg3cr7hTKTZWeRpWG7AeF+jRyvj4amk4laZ+gWbAPjQnEN/vHdBt6LEpiX/CNESiK0sAb7VyuepAzhDV1nxtadI/KnOL7Jw3i3/9xqtlJvGEwgrXy9OmJ7xIpL5DlGEKU6xUdIET/q1TO61hvwo7lMUmqDmOd7Xr4fV8kMV4pSzU5OffaTiySGHPqfA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151ab3d2-8a15-4592-3a6a-08de8a2725c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 04:29:47.4295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zci4IyiGdtXOKADJE7OV5o5nhFGSuH2Br37qbyg0OBNUok5bsoXu8UEKB5UZbb9K2fTGNlISQHIxZKke9mHSPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6498
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTAzLTIxIGF0IDAxOjA5ICswMTAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBGcm9tOiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+IA0KPiBTUFRFX1BFUk1fTUFT
SyBpcyBubyBsb25nZXIgcmVmZXJlbmNlZCBieSBhbnl0aGluZyBpbiB0aGUga2VybmVsLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogSm9uIEtvaGxlciA8am9uQG51dGFuaXguY29tPg0KPiBNZXNzYWdl
LUlEOiA8MjAyNTEyMjMwNTQ4MDYuMTYxMTE2OC0zLWpvbkBudXRhbml4LmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCj4gDQoNClJldmll
d2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=
