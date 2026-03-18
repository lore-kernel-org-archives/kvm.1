Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DAA322B88;
	Wed, 18 Mar 2026 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773816890; cv=fail; b=JMwOF3X6xqGc43dvLTz8a61OX7vLZOwekiOmYYFhowGUAjUDfvh5v/HepDlYVzydhJu+5v3XXDtd0lnImTMp3UKLO5FwhP2BiE2wX6arX0pLrtsQZ6l7UTlR3W5VP2QJRS4IkDFhXbQLwzwjDW078UGZXnXPZGqZlLllZIScQbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773816890; c=relaxed/simple;
	bh=sjSKBlqv2Up96g1OO70LMXkkyV7daNEM0gywhFl+4fU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G61+b59scB7z6ekx3RFB1svXAlrUxlpA4yVof1olfhF/ufTDhoaVD90KZRw0M3XCwmwuy3zzAmqugoEI+FMkvJwPdhaDCwpafJ0Kix9g/hG0HagTZy9TGQMoirf+JU/ip5moVzbIYBL1xHtAUHVFX3Qq1Ti8Iw9IWjDsBPR6uwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFsfXIiv; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFsfXIiv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773816889; x=1805352889;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=sjSKBlqv2Up96g1OO70LMXkkyV7daNEM0gywhFl+4fU=;
  b=bFsfXIivQLkMhP5w8z676+WEewISNo1Qfgk1icg0RAxpG7uF3z5hizXW
   hF+oqnpJVHD+5FzDvpz2YWSCynIhC/8r4+bCv1u/11GSsoYsiAUTsH8Tx
   ve0x/KJ/za5bmyrf+ZXhoOASgji/iTP812S6Z+SmE9zB4AoQsyeuTgutO
   Gfy9pMLZgaUojwJ1fz0mB4X8ObUdIOxGXeT3eDfhWf63Dq5F3Ym8wbxot
   nsM+GyozJvKXNY3mtjhuwF1WPR9iCoa4jZlYbA3DczNoPCr5AHG6YhRHM
   tqfcugqBmW05zQCgGbA0hvCxoZdCsC2yDpM2nlBeDST7roXimxRBaP8jj
   g==;
X-CSE-ConnectionGUID: 1T/uq0rTSQ++8gja3ULX3w==
X-CSE-MsgGUID: G4kSJXJqT8SReXX1iWtyHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78763151"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="78763151"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 23:54:49 -0700
X-CSE-ConnectionGUID: P+kAEjw1TuO7iwCIjggWJQ==
X-CSE-MsgGUID: A7EimthETSeUhnJJ4yXJFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="260419278"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 23:54:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 23:54:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 23:54:46 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.32) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 23:54:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4h51VyfG5C4NLHk82Irdmmsz1BVE1CHpet2K8yzijIlW1jRkZpgLX/6YUve0o6Yp1bXaG9xYwPuLWxeHEu5X2eBWKycp5d5OhlBCmcMYoU8cE85CifAatbVZz4wAh+XdDY+6smuhbGd8gz+qcD6xUbLxR7O7fd7g4uKMEAExytPyWEWl+8CeMaWXK7aPHw6zq1epYj4SfzF14yl64sOfwyT0flItoWWY5FsBlHUU2EaqG/hWiCvt+aoDGxM1YowE0QF4CGjfqBNUpe2xs2uL7kVwYw4zB5D40EmExenEqPD1jSuvznjCTA/Vj6iZH2xUJfp6f+hA/rOelU5K/5zAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRW4OmuTvWdkiOzJibFE+rnsE0aBoEziLnknqkUOL5E=;
 b=A4Od9SjatdWBZF825h8P6aYSvJaLYeOdHm5hXuSg/vdv6cFdSXgHDg/HmyZTPth/mk+/O7cmPjzS5To6xWMV9ICxr6RGnQ/j/d2mvlKt8wHmCNbHvDYUWMtRZ7KGCaKq0UHP4Dm09uBrmfyC7zuTh4PqGkaUdsjXxUS002jpqQvNvyyy81ydqCql0wcBhSUIY8yqk+rTs32LDVv5wfuGFxe7OYLAIN4Ns+8kFfLmAJHN7/znT/L6qej0jkrvJr4EtIAk4Lh6fLyGurD8K2u+fwjlRtsOUsqa5nI/I+L46GnjiVQogmXWq5pFzmhGP3y4klzfVbjCLwI8fQmAGx627w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 06:54:38 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 06:54:37 +0000
Date: Wed, 18 Mar 2026 14:54:23 +0800
From: Chao Gao <chao.gao@intel.com>
To: Kiryl Shutsemau <kas@kernel.org>
CC: <x86@kernel.org>, <linux-coco@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <binbin.wu@linux.intel.com>,
	<dan.j.williams@intel.com>, <dave.hansen@linux.intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <nik.borisov@suse.com>,
	<paulmck@kernel.org>, <pbonzini@redhat.com>, <reinette.chatre@intel.com>,
	<rick.p.edgecombe@intel.com>, <sagis@google.com>, <seanjc@google.com>,
	<tony.lindgren@linux.intel.com>, <vannapurve@google.com>,
	<vishal.l.verma@intel.com>, <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v5 06/22] coco/tdx-host: Expose P-SEAMLDR information via
 sysfs
Message-ID: <abpMHxwhYqbmrX8s@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-7-chao.gao@intel.com>
 <abkmceqUtMTnLI0V@thinkstation>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abkmceqUtMTnLI0V@thinkstation>
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|PH0PR11MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: b008b45a-ae76-4dbe-ea64-08de84bb381f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4qBn+blDbuUmJYOeFE8cIxjJhR7lQrvyENhq3T14IX3a/aVK9nX45fnk4Iwx4Be9F0wZqyv5vcl11a1Ag+CuQ1LUOCw9bp2dgENz4YmsDTCZ04ZGXzzPho+vhHF6EmR9ctA4rd1sb/T//yg2ZiU7q5914Qw72rZSLAuul32kPLpgyQ9l+zll6RrLBOAThNT6GmbzBS9dFN5woQBfhmdyyWjM8EtSf2ACIQYqBucCV0PihiJZGWIVlmk8z6Yg/4/OkxCJ4Ng83AJjQP7oSyH6NeiGdvRlUg2JJXkvxSEClpJemjn2wEM9oJSmB2NvGJ8FmDPdeWzp8uTsoDdun9KZpf0GqYfk35w5au+wqkeRIM0BxDr0A/OVvcpUt8bCMnxS5zI51Uov9O33SteGFNzTAgZMKsw6fgOz2UuysiDVKC3v+LbmGmuQvNymfKNz5rM/kTWSv82fgMJkXqNRb3jbwi3SXNHY85sQ1UchtWMY70gYtLacUN4O1QACoF7A6c8VVTHxJVNBBb+iBkSC4xD1CRHwvaKjihby0xM/fJv36xIvMB4EAo9+YbDNUCkGlEgiwhrHkSu80gyCBX/LYLG/pBFS6PhJIVNkUF7ST37q+Vkidmz/6KBmO+i83kLZKCFW9fAAffz81gcAi64qjf3kfORVRs/Jp3mC0Vnk5go7VbpD+kAaS82+l2yGUwEdT+nadkil3VWmf1kcziZ7DA8kdz3Jln0SuaPmDGAvF45Z0UQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?t/pvtCCL7TrGjeiBaCNz0Jwyz0UqofT38RxVRGqt5AZ0sJ4CeAwx9jt5VU?=
 =?iso-8859-1?Q?qc1hhGPJBEoLCKAU48T+bKJ0rh0hl75IOa6jaj6TuqcIF1dUqifymhp/R+?=
 =?iso-8859-1?Q?en4zNWcuT+wA0GB1wvYnQgzEHTV3M98haSnbJIi47gsTXHXfyQoxoJnPuA?=
 =?iso-8859-1?Q?wCJNCl8XZKlBqr6wfoxFRRxH3OZdcRxZPF7jB1fzJ1o9qy7cOcXnq6zi0d?=
 =?iso-8859-1?Q?fvILmJ8s/nIczeZGfX9gXcZ08PjyPvpSyeWulAJPBCeLXjqZPKPlAPa88u?=
 =?iso-8859-1?Q?RlPd10bCPqbaW9P2iFzZebUiJ/+flNkFknpENUayncZkAxdkm/oFknHys+?=
 =?iso-8859-1?Q?/fnzXJTBTfN7VZt6l1Tyk6hgKn6MfleZuzzH/WYfEfrQaz6oO+A35Pr1Wz?=
 =?iso-8859-1?Q?Ccwsm9eQclgWxiLOsfY30Eb46LxyelqOFmsnstlUMe0h2Rzrp5XOUXWA8N?=
 =?iso-8859-1?Q?/HlVuYQtf1hN+lC5D7sT4mYR1dhbFjvX9lDG8gmjIrSUVEcVrg8/S5BAaQ?=
 =?iso-8859-1?Q?RG+D4xcdz1DBFZJEQXdyuBOLK/qBQo01hroE6XY9sXche7NCz/FO2roamn?=
 =?iso-8859-1?Q?ZoqQTv7d1+4ZvBgkT2t8w4Gv0GAWSq418WgkiK6GgcGh0RoTDOHcxwNrX2?=
 =?iso-8859-1?Q?GLfTscSXMUxEuIbwM5ihiVSINCGhrUcjlc9lDrzteZS5kLO4B+FSwuFnvU?=
 =?iso-8859-1?Q?B2TfpfoNRsaX/UKEsSISPNvq0V/fZgD6qApDGhtkHAAIGcVvqynRYfKA5W?=
 =?iso-8859-1?Q?NBfHwudfziUz5fEkd4P2LlIWJsGiqmjDcTrF4Up07wEGhs/VafVSI027pi?=
 =?iso-8859-1?Q?u8jQzeMoDJi7ScL9nZps1pPIHKeZx4s94y09nA/jTPoWADn7rt818EFg5v?=
 =?iso-8859-1?Q?jDXOhMx2ijxWBXyBn/jZ2+gDAXI3KRxqyI3Pc5MmTNVDZAaZMueWW33sQe?=
 =?iso-8859-1?Q?XAIcylmXgmHblScKZlbNYJ3F/ZgZi8v+igx9jhKgKHZe63hoY64SYoOoDY?=
 =?iso-8859-1?Q?5zclh7VmK+9TOp1mRaThkGPgzCqNgfFFGMxEZeaXPOSA++XEGVFXw06733?=
 =?iso-8859-1?Q?okrt6kSWdixhTb4NxrP7IpzFTCIxYevFXE7lrmF2OgHvQoE8qiHp446JxW?=
 =?iso-8859-1?Q?tTXf1ZHaVgZXXwSSbkCjSHYKme6uQcFhxztgfo4xnqkJ8BseClmC4di5rH?=
 =?iso-8859-1?Q?P5Ug+azVzlMUUD+OIQ6CWtr7hVgzwoh6NDhlNFZZxk8KtW1a3v6CXje8CR?=
 =?iso-8859-1?Q?z92odjxm2x24JB8rWIffAZ1xk5Uwc8g6SP2qgAknd09jYfKei5D/NkdJ9c?=
 =?iso-8859-1?Q?p507jPe9pdr1IkQmKUQuXrehKCzrOaOrqGumEeBzCE9hAg8qwElLnhPs2+?=
 =?iso-8859-1?Q?uELPWC7XhWxQETbzVIs9NIXn8Ls1XzhCM4hqTBOeHVoX7mgmoJNiN3C8SR?=
 =?iso-8859-1?Q?BMkUQuwr2ZUwUMR4CWPLTCAl1mrsZlIbO8BWDQ4qunY9xdF5VipQOTvl6r?=
 =?iso-8859-1?Q?BppVwE0xWejfOp7vsy1sz4PP+yGJFXDcuTki36SISvsnNNESGSityXLI9+?=
 =?iso-8859-1?Q?GWAxDftaqfdJOmzFx5kqMp3sa1gzN0JFRPyTp+mCmCmmHRU7wf2fqlOjjh?=
 =?iso-8859-1?Q?SQKSRbQsr4vj7WqmXybmRLT7Y5pkN4XT55eENH3sZjvNCMn8FiP7fwgSfg?=
 =?iso-8859-1?Q?CkuOvOYcEt6eZOLt276wRjBHefZ4HnSX9vVkYoCFl6Tnw2uUdHZUlwpYvq?=
 =?iso-8859-1?Q?JOmg7Afay3plflHt53WawQcuk9Hz2DEZDdBXdsWqXILTaqTpCahUiBXvU2?=
 =?iso-8859-1?Q?bwrE3VmXSw=3D=3D?=
X-Exchange-RoutingPolicyChecked: wSQUyVesyfZ8n9SbTIjvLhupE6DrKc3w2jY6OjaQ22krBSaYVuL2DltFFZdFeJQqQTvMCKXr7Ye/A7S6x7cQ6SPmOS9mMVqrXGVpDi/+NVtTAYpMTJfUHjYm5jitFshlL9tgJz1fh7qVSgWiaq78TOzVFQISENZAYejvog8+5BxYwMXxaLEsfJc8fg92Xi8x3ZzlpOtODmCYSMwZi2YL2OX+MaVV2aWDYa0ASK3lmFAD7ChPY5hqPeSgNZ6jovUbVN6mvRKsYIVzqxOL4Vn4TJTzfb7OFB609v+AcU2JmcHh5WWKGx+aQb44Q/NKYkNbcdOeR57TuzxBNDaTnRyd4w==
X-MS-Exchange-CrossTenant-Network-Message-Id: b008b45a-ae76-4dbe-ea64-08de84bb381f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 06:54:37.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgOIeJX/XV3qTGN8zOgkVLH/btM1WHZUYyNlA+U7WuErGF2g3UwROchpOISX0Csm/pX9gXHO/QLXXc8TUWixFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7585
X-OriginatorOrg: intel.com

>> +
>> +What:		/sys/devices/faux/tdx_host/seamldr/version
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:	(RO) Report the version of the loaded SEAM loader. The SEAM
>> +		loader version is formatted as x.y.z, where "x" is the major
>> +		version, "y" is the minor version and "z" is the update version.
>> +		Versions are used for bug reporting and compatibility checks.
>> +
>> +What:		/sys/devices/faux/tdx_host/seamldr/num_remaining_updates
>> +Contact:	linux-coco@lists.linux.dev
>> +Description:	(RO) Report the number of remaining updates. TDX maintains a
>> +		log about each TDX module that has been loaded. This log has
>> +		a finite size, which limits the number of TDX module updates
>> +		that can be performed.
>> +
>> +		After each successful update, the number reduces by one. Once it
>> +		reaches zero, further updates will fail until next reboot. The
>> +		number is always zero if the P-SEAMLDR doesn't support updates.
>> +
>> +		See Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
>> +		Interface Specification, Revision 343755-003, Chapter 3.3
>> +		"SEAMLDR_INFO" and Chapter 4.2 "SEAMLDR.INSTALL" for more
>> +		information.
>
>Do you think revision and chapter numbers useful here?

I think it's nice-to-have. Without specific references, people would need to
read the entire 26-page spec. But I can drop them if they make it too verbose.
