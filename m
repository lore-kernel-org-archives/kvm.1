Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C572D207A32
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 02:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773110146; cv=fail; b=Z7Yh9T4bPgq0bI4W5wG7u1/a+9TAv4tOk7tuZp5f/U3MdhYMWmcTsuK8pAKy8uwXpuN/tc7qBkojrM55COr4rnRVRzomt9CJgjq0IHZ0YL3gN3ptRxcruqgl2Sd04rU8Dfhbbr388rt3ivlpIMWLPitj76u2lDLPSdgfuvRGVRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773110146; c=relaxed/simple;
	bh=SotWjBlGiJYJjrkOqqJSOvJsTPjEJxEF9be8RMQRc5Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOV/lD1qNLcgguVGuN/H4HPL4l2NaMuIL1bD3rnvb4WrgAtIf+0cwZwkYUaigG0/+DDIw/6A3uBQ8qeFvL59b4a4ZMG6XOHq7ub9hQzTrPERdYzZg1jSpji5Oy7y1VL0Ke6vNBQxEgMJtHS6nPnJ5c5/AvAl+6Bh399nnvq8/u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwfagKsa; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwfagKsa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773110145; x=1804646145;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SotWjBlGiJYJjrkOqqJSOvJsTPjEJxEF9be8RMQRc5Q=;
  b=CwfagKsaMGc6k+zaw2QqkBMLv3qsEmGJhuTdCrxaNfHObQ6qhDWoeZnN
   eiRw1FxrdbfI54RVdOgwfRtsBGCeEFbO9IjhCzZ/CxWDMO9L11T7mV3Hd
   kPOxZoymFjmtReUm0khRHaBC4C+Y2YSmCZ8Y6iYRHyUn1xTCJu4XwL/b/
   sWUxPNCJkExPCIl15+JTDvKsRNraBqcN0/MU3HpVhgZZ3fzkTFgLhiudC
   kRe6dNd7JSJZzH3d0Tm1c1/icMg6ungFdj8tdR/cLqDehHJuAeBQ7CYmX
   dX4QNO8oCgZFOC3fk1lg+YXySaBI/R0qX2zougPhpBiGSuE7mN7UkxwdK
   g==;
X-CSE-ConnectionGUID: j3Ql+YeQTYaMOeajyLYIcg==
X-CSE-MsgGUID: oiW2MgCYTzSalbk3IgSPXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="73846328"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="73846328"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 19:35:45 -0700
X-CSE-ConnectionGUID: iEOiwasVQp2Q6lMKvfRFDQ==
X-CSE-MsgGUID: YRKXG2VcTSazhQKrwVBIoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="217962168"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 19:35:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 19:35:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 19:35:42 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.48) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 19:35:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAYE3XpZRwC9b72UEQ/soLXeauGN7ebELo5GD3ZCjS2/2fIcvnfO4Y8s3or9uwccmK5DByqETyfvjtguHh0v9gz/i2m/Aer0WRbcmnYMh6dg7BV6SoDkoqoHfDUQB8mVeLC/RGbncNwwM7pqeLmMK0qHu9OqM5nUO/T16eTDN3915ghJPdugodxDNM7OR0WDympQgMnjKTgbCnU+6POY4hN7A794CcXI3CmwT8EJq8PuTUEheWn+4imTT8onOegD+abOol8BeQPjtKzSeuTnvMcJSKKLuv6t18A2r/mhKVAsWtGN6OsxqGwCoU/yOWJjyaioEFWZpRTiz6lcmJnlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV1mF3b7Ao0TxjfoouYDG9pvtDpeOppilN0jVPY6u8I=;
 b=liLcA2MgaIKn+o8kZn5sl1eaSvJUWUqHJvolhOjL0DR27Y7LROZZveVYPjsEZqxgPSgOU1ltFmZYZ/+Vl+Mxt0SeZVdelS9Okbb5jDC18EYP5P4bw7zTuJoR2imGkHfvyPEXcWbr/xS1f9UZeCGtjXoFYn4bnLMPve+hiZLzKnKUKuD8pA9DSGPEiFGVdAoOj3zwkwtiOVtTvbLCTpWWr+AN+x3SqFm5Q/3NW/1uaAK9Q+9ZvE8zV5c9oyi4cz9VNeF61weyw+QerzcgA8EmRHgvNIkmybrQOv32hnqwmDn6kpXKTzPWpjDXTsZv0PzzbSIj37BnmuIXxCkb8I1BYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 MN2PR11MB4520.namprd11.prod.outlook.com (2603:10b6:208:265::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 02:35:35 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 02:35:34 +0000
Message-ID: <ce681660-d47c-4ba6-9237-eef55a87493c@intel.com>
Date: Tue, 10 Mar 2026 10:35:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Make RamDiscardManager work with multiple
 sources
To: <marcandre.lureau@redhat.com>, <qemu-devel@nongnu.org>
CC: Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>, Fabiano Rosas
	<farosas@suse.de>, David Hildenbrand <david@kernel.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Xu
	<peterx@redhat.com>, <kvm@vger.kernel.org>, Mark Kanda
	<mark.kanda@oracle.com>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|MN2PR11MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: b48c5745-4179-4d8d-7799-08de7e4db4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: DZTgSWFEN3scZxCSw1m/WEFuPg8eVgmTjxsPdSeb0Ezp+sMaWdWsaQ8BePhu1zQ7cmeqEmQ6K/eG2GMS+9LJGwa7noId/sYTX5b4EjA1tKSIOd9PNXD/ej3mLjjo50IbJ9SXwpot6/FHyDK+pBMegCSy9EN0lB6f9/zlD5xnMDUWMCDhD2ozvAA+fpUIkGkBlEyKhMd+3nuPxNo/sbPzPvFQEsEgIrxtA7d7OsEPMSOr6HkJbt+TMSPJhYr+zwnRPMzMIuYh7EXCr5wkydh0pXSvqI2MzjFUFBMPXVH6FKIfMsZm6jpckZLkAeUSQRSTOhPcQAF9JFEd+VtBRD9hD1J+rsNJB53EOBvYyBCfGEUSFsCh1/Olm/rkxwfuRmij703vMHpdPlIfW1GK4iHqVm0Tuqi7jH9dv0lZhkiAIamGZiU7S/LXlSIkKVBN6ycmMMcw/Fc03f1sc+tmSaNfrY1x6W9dhm2uedojaFyKg8WX9V+y73MfwaE9JsPiy7b7YLJNU9G+58RltsQObzVULPWz0gExKdrclPRRNXt26O7bmwFpEhZStQTRK/inLDQgk8k4YJgZpguyjvVVBT/4PDmeOtU19VX5uc3jqeU4o8o1hb7cDLwfVkujhaWEOLEze7O+a5/7F+rNtDM4WRKjUB0gqcfI/i7aXvc6/itgKcOC14icDjFN1QbTHjce3H5l2I1NwYFgrbhE9A0J4/eIUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wld6SmtwVUxDSFROcXY1SUNzSFJyV3dCcExZdUhhSVp4bG1LWFlROVdTY2dI?=
 =?utf-8?B?TVM5SUpMSUtPNTlPVkhYeFhodnVmU2E3c2s1T2M4RG4xVmMyZGMydXN5cGR6?=
 =?utf-8?B?Uys1TmlZOW9zeHBBUjhlQVAvc2JhQ3llZk5CdWVwVXQxWEFSUXQzSGY4TlNv?=
 =?utf-8?B?UGY4LzN4MDNTOHh1cDQyNnBITWRMZlVGNEFZL2REUE9aR2F4UGlqZmx1eWlv?=
 =?utf-8?B?enNSNVBUM1U0M0hza1o4OGgzVStWMVVDTmxnVk51L3JRUy90U2dRZWpnYXly?=
 =?utf-8?B?Z1NKbkwvNWJTdHdPUWlWaG9aanFYZ3p1bWI1S3hyYldyMThkVDlzRkJRSThG?=
 =?utf-8?B?Wjd2NnpNbGtSczRaSlgzcnJuVTFobTJWSmtqeFJvaEJxUnZydjJVVC9QTk9G?=
 =?utf-8?B?dlRIYXNIRVNDM0c2ZEd6OWRvWnhGQjJGeFlxMU9mNVZnL3l3QUo1NGFvM2hO?=
 =?utf-8?B?bUNMWGZUclZuaHY4ZGZmN3dFeDlVRzFJNFZ2dm9pbkhtTW1XNGRnQW5TR2No?=
 =?utf-8?B?Yi9ST1BVbzFkTTlNYitiRzlaMEl2ckw0em1DQkM3M2N0MEpUazBHaDBtd0FK?=
 =?utf-8?B?Y2c0UzJmWE9UeEkxVHlZdFJ0cHVnN3k2Y2oyUXFWbE9hQ0NGWDlVN3ZUQmZM?=
 =?utf-8?B?TW1MTGRuYnpsaTB1a1VLVW5SdmI5TERkY3pFWUdLRzR0RE9WMFFLWG1maHNT?=
 =?utf-8?B?VEtCZm51Qm1mdFhNbnM4S3pwanZDMU55S1VuMk5SN1UwS29Od1BxbmNNK1gr?=
 =?utf-8?B?VEI5UVlWNUtOOHFlUUxoRTRlZGxQVzJsOXlTNnRGS0JmY1VuUDVhQ2ZjUjZ1?=
 =?utf-8?B?VE5pMG92Yjd3dWZLb1FkZnlwOFIzYi96NE5xWkVRRjJvVk10NGUvZzBwM0ZO?=
 =?utf-8?B?Y25hSVljZGZQc2ovekU1cFZGSUVYWmZRaVBZMlE1KzJHa1haWmh4dS8vK2JR?=
 =?utf-8?B?RDhZR0JYNnlWanlNaWpyL0dvVmgwcWVuSXNYOTVBcGdyTzZMUFNCK1lWYzI4?=
 =?utf-8?B?d2VNbTcvWVMyUVNQdFJRa3dqUmZMV0RoaHpncWZ2bkNLTmtoajBIVExtdVFq?=
 =?utf-8?B?d3V6K2xKREdTR0FsMDZLU0pLeHcvMGZWMHp0VUthYm5tZ0dTaDR3MHZHeTM4?=
 =?utf-8?B?azZvVWRSL2tYVWpzdnFtZGFaM3YzNkE4TEdaYWI5UEtrVDJzZy9NV2QxRXVR?=
 =?utf-8?B?bnJPUjViS0pxKzRHL0t1UEJicWFwaXRZN3hiSUdaVUtMZFBHTHBRRW9KUWhw?=
 =?utf-8?B?RjBvUldiT0xaZGtWUG5aeXBoVTBRdlh1alFRT1d3OW9malFPWnc3K3RDZDM3?=
 =?utf-8?B?V09idTBJOXRFdDBnblhmOFFCay9TeHR0UWt5VXQ5NzNIR1pLU2JjaHdLMW5x?=
 =?utf-8?B?RG9WMENtVE4xcmUycXpnMkNkSFI5SGxCUGNtTjdIcktiWXRzTXRjYlpybmc2?=
 =?utf-8?B?RkJ3bW8ydTJKbDBYUkV3SFFvZXE2OE90NWlsNlFLQ0xaRFljNlhzZkZLalY2?=
 =?utf-8?B?RUhuZkNCbFg3c2R4ZFR4VVpCK0c2T1hwajJoRWxXL2V6QU9jR2c2bEU4Q3FS?=
 =?utf-8?B?ZloxTVRBc0FMRDk0c1BLTnlvenY1STh5ZU1ib2ZUZm9lbUNyRjhqaWJZZFFI?=
 =?utf-8?B?YUZ6RlBlbFR0am4ra2c1NjBCR1pPaTNWNUE3bnVnK1Y5OVZQTzNEdmVXdGll?=
 =?utf-8?B?UVJDeHk0WWFmYnd2SjFpalcvME9SditDckM4Unhka25mMTZJVitvRjRITzZW?=
 =?utf-8?B?TUt4QXBETlNtdGhWSHcyc2hiT2Z5c25Sa0w2dWZ1VG5yQy93T1FrR0VvU2JM?=
 =?utf-8?B?VWxIdlorTC9KcGlLU0Z6b2lmQzcwNXNGQnFRdktEMXV0cFBZbHNpc2JWeTM3?=
 =?utf-8?B?bzR4RG1TNHBqQkJqRlF1S1RQb2tocTVMcm1aK1J2OHo3cklMd0lOaGhwOFlr?=
 =?utf-8?B?WUJtaHBXSktrVE9OcVlPWk1nQWpVdEtzZTVkVWRhdWFqb25FZ0h5RDRBZWs2?=
 =?utf-8?B?WU9hQjl0UzlnRndRNjlQL0sya3lOdmNQM2RmdnB2QW5UbEdzTUsxN0dEUHZu?=
 =?utf-8?B?cnRBQmtFdTluNnUxSEJGS0ZObzhYdTE5dlQ4TlhZUlVzYjN2NjY3cnhxUkp2?=
 =?utf-8?B?UlM2VDE5N0l6YU94NHJyNk9BT0hCMnh3aHFmem5pZEhCN1pQYWdHbW0zby9N?=
 =?utf-8?B?c2lwMVFETnB2UWpVSThRQk1Ed284VFAxSkdBckpheVZCeW5LeGdOYUw1RHRU?=
 =?utf-8?B?Q1FiRzlpOGIvVTJsNGVCZmtIN21OLzBYZUg3TThUODNqMkFBOFdUS2gyMWhH?=
 =?utf-8?B?cFRlT0dTQ1RJSmpTN0hxTUhkQmlHS2VSNTVPUTBMaTZQZWd1d0VPZz09?=
X-Exchange-RoutingPolicyChecked: A0ffx3P3ZuGZBQOLE3uMX6y8h1s3+8Y/RVZ/VcTv9X9o1YuOYQdIndaEbAspoRqc8bb3ItkQLt4qkooktbtzn8PSDij2mTmcYjEZ3253qZx1F2/ZWORkq1VF300LYgSo0juy+8L3gN2S1ZeJUldUCSfifKinZrxKmXwrTYcJOULS1HteqoEt9wb3GfxyguaWm2YApOWQyi1vZpuhnIp0s869eonjOLmzCcDqZD7eA062GW36xqJ7KDaA58FMCHM3faCHHfTjRxBfJteZFM/zcxwgo70tPOGz3oYElm6wXlagIATG4oqUSUFow9xZX6J1ZNm1tNEvTkClPPxUXaowQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b48c5745-4179-4d8d-7799-08de7e4db4e0
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 02:35:34.8440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoE19O9sc32ebMBb13hvzbq+g+MCGDeXGp8UbnBXiNSKMN7cEHBbpO8oUt9aagD7nmREIFlZRfJs9eSq0yUQag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4520
X-OriginatorOrg: intel.com



On 2/26/2026 9:59 PM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> This is an attempt to fix the incompatibility of virtio-mem with confidential
> VMs. The solution implements what was discussed earlier with D. Hildenbrand:
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238
> 
> The first patches are misc cleanups. Then some code refactoring to have split a
> manager/source. And finally, the manager learns to deal with multiple sources.
> 
> I haven't done thorough testing. I only launched a SEV guest with a virtio-mem
> device. It would be nice to have more tests for those scenarios with
> VFIO/virtio-mem/confvm.. In any case, review & testing needed!

Is this series aimed to enable virtio-mem (memory hotplug) in a confidential VM?
I tested it within a TD guest using the qemu command:

qemu-system-x86_64
	...
        -m 2G,maxmem=10G \
        -smp sockets=1,cores=2 \
        -object memory-backend-ram,id=mem0,size=2G \
        -numa node,nodeid=0,cpus=0-1,memdev=mem0 \
        -object memory-backend-ram,id=vmem0,size=8G \
        -device virtio-mem-pci,id=vm0,memdev=vmem0,node=0,requested-size=300M \
        -object tdx-guest,id=tdx \
        -machine q35,kernel_irqchip=split,hpet=off,memory-encryption=tdx \
        ...

The TD VM will exit with the error when the guest kernel loads the virtio-mem driver:

    kvm_intel: Guest access before accepting 0x108008000 on vCPU 0

I think it still lacks some support to accept the TD guest memory before using it.

> 
> (should fix https://issues.redhat.com/browse/RHEL-131968)
> 
> v3: issues found by Cédric
>  - fix assertion error on shutdown, due to rcu-defer cleanup
>  - fix API doc warnings
> 
> v2:
>  - drop replay_{populated,discarded} from source, suggested by Peter Xu
>  - add extra manager cleanup
>  - add r-b tags for preliminary patches
> 
> thanks
> 
> Marc-André Lureau (15):
>   system/rba: use DIV_ROUND_UP
>   memory: drop RamDiscardListener::double_discard_supported
>   virtio-mem: use warn_report_err_once()
>   system/memory: minor doc fix
>   kvm: replace RamDicardManager by the RamBlockAttribute
>   system/memory: split RamDiscardManager into source and manager
>   system/memory: move RamDiscardManager to separate compilation unit
>   system/memory: constify section arguments
>   system/ram-discard-manager: implement replay via is_populated
>     iteration
>   virtio-mem: remove replay_populated/replay_discarded implementation
>   system/ram-discard-manager: drop replay from source interface
>   system/memory: implement RamDiscardManager multi-source aggregation
>   system/physmem: destroy ram block attributes before RCU-deferred
>     reclaim
>   system/memory: add RamDiscardManager reference counting and cleanup
>   tests: add unit tests for RamDiscardManager multi-source aggregation
> 
>  include/hw/vfio/vfio-container.h            |    2 +-
>  include/hw/vfio/vfio-cpr.h                  |    2 +-
>  include/hw/virtio/virtio-mem.h              |    3 -
>  include/system/memory.h                     |  287 +----
>  include/system/ram-discard-manager.h        |  358 ++++++
>  include/system/ramblock.h                   |    3 +-
>  accel/kvm/kvm-all.c                         |    2 +-
>  hw/vfio/cpr-legacy.c                        |    4 +-
>  hw/vfio/listener.c                          |   12 +-
>  hw/virtio/virtio-mem.c                      |  290 +----
>  migration/ram.c                             |    6 +-
>  system/memory.c                             |   83 +-
>  system/memory_mapping.c                     |    4 +-
>  system/physmem.c                            |    2 +-
>  system/ram-block-attributes.c               |  279 +----
>  system/ram-discard-manager.c                |  612 +++++++++
>  tests/unit/test-ram-discard-manager-stubs.c |   48 +
>  tests/unit/test-ram-discard-manager.c       | 1234 +++++++++++++++++++
>  system/meson.build                          |    1 +
>  tests/unit/meson.build                      |    8 +-
>  20 files changed, 2361 insertions(+), 879 deletions(-)
>  create mode 100644 include/system/ram-discard-manager.h
>  create mode 100644 system/ram-discard-manager.c
>  create mode 100644 tests/unit/test-ram-discard-manager-stubs.c
>  create mode 100644 tests/unit/test-ram-discard-manager.c
> 

