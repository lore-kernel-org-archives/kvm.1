Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A7A6F2F2;
	Fri, 13 Mar 2026 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773404194; cv=fail; b=EADP33QyxMBOURLK7iwVb9NQ1AuyhH63Z0tkq5Eb34v8zRuFrB7h967agj/UgAAn0MoZYn15jbteFhs103Y2L3AgjCBRybGKVhEM+I6IxqgZjZccHvcSrQMPi9bQPT+yhWfw867cCUFbNOaYqkwbppVwQCyMkmqgL1IbxUZVqrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773404194; c=relaxed/simple;
	bh=F7AKX0M5UwKaPzP9Ul5OhsDtjoVqC4gjvCAVb1ngZsg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kwl8LHXSxRIyXwKmgHyVhgaU3RjNWfaJS1j0ZwICSGisu6R8P8cD1Il24QXObKqLpZ2nlmQ/eAkO/ifBMCr35sEf5BIGPMXC6m5y9te9GM/bqkePbqzDblMsYZ50qQ7cuI+dJsVhSSowIdmQ6mJOCEQ+N1kvnzuMIOIDiPYlMzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/H5HFfq; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/H5HFfq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773404192; x=1804940192;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=F7AKX0M5UwKaPzP9Ul5OhsDtjoVqC4gjvCAVb1ngZsg=;
  b=n/H5HFfqcKPg34s3rzJkiZKffPKFpnvVbA49pFrj8yShimoO4XzuxnEC
   0Wi4ky69CWc1nDpt7/meeoTMkIdsiiTpnoNgDjcYG8raQC5zyG/37z3p8
   7FsmiCFJMO6NoI2NLx+oT+IJNscI0X8JJJFvj/8HtT885ZWv4o9vBBkpD
   u2S7lKN9HT50r/8Qhx/RBDh6jNkTx8+zzuwChkSTXxKSma0HcFQ/qeC6K
   HSfWDhHgmmQkTjS24yF/2T+kRjsuxKW/Pil8S5Zspc+Qs0Y5OliE8gUlp
   YNKmdYb5Qw8I/+7ITgjqQPoR88yGu5R9JTljpzjwX0X+BBc6Klk102Bpo
   A==;
X-CSE-ConnectionGUID: zLApLns3Qo64R42pfd4KdQ==
X-CSE-MsgGUID: k+AmdrXWTf2rOKsj4R9k1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85864728"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="85864728"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 05:16:19 -0700
X-CSE-ConnectionGUID: zMX+A2NqQ9aQU2MYzXrBdQ==
X-CSE-MsgGUID: bCLnUrbNQbeRg8ExEsZt2A==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 05:16:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 05:16:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 05:16:16 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 05:15:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7w8FTSi1Bl8lUBATkJ6MkR+iGuKnj4OrnxngvHysawHQZUWqgFNMEVSLFgxWYxhy5BK6S1yGfSz6VdreUChUC7a1wNRHzCI0ICJyivyhkZ40BbnHoQfCfTeE48k0TnDtqJkyUju6+T4uByKLV/1xMSBSSEoqKwdekilEcBqDNf2yuOSLGAvkTIem4RdYaH2pnC3oGSYZ5OUJXZVoVJDLiYYMxypg4RMSUSIKEVZqczjpgF36MhGOG+usNGqz9qOjCInBbnQd0aG2WYhs9BF1cQWm3eh0ryr7iZ6hhTybU+yy6hrAI3ZfX+608ufyYPoJU+/wSeiYoC/U3hPtX3PfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nUeynBdW96XxEi5SCGJ5RG08yQ+bcVtMQchzh85lnw=;
 b=YVOcISLzgT4+exUt4T091NxUMCi3JIcP+Knqr235ZavqFBH7S3eV/j7kOnYC+XQ5Y01dNnLNHKYgHjTUTsH3cZes+M0VxXxCyvH9cOMoazbKaz5etsl9Gi6kJLPPQW77Qj+K3bpTZHDy6kvSMYWHdLwftC4bm4ipky/th1vuCDBQ/DRTIvzJ5+2C3GWsIgsa27V35hWgcRyz1wj6kRCxJGUUCxJDJ6lfEeYELh7kb1gVp0eTbuXufEnXSKcerXoTnFU6XmDnXDfTp8oU5lGpllxHzfpu72f8VTYE892UIF+DCBixUl1YTp28FUGfpTMkuQLk9KSBT2fUula8WWLVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by BL1PR11MB6050.namprd11.prod.outlook.com (2603:10b6:208:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 12:15:35 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::fdc2:40ba:101d:40bf%6]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 12:15:35 +0000
Date: Fri, 13 Mar 2026 20:15:22 +0800
From: Chao Gao <chao.gao@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, <x86@kernel.org>, <reinette.chatre@intel.com>,
	<ira.weiny@intel.com>, <kai.huang@intel.com>, <dan.j.williams@intel.com>,
	<yilun.xu@linux.intel.com>, <sagis@google.com>, <vannapurve@google.com>,
	<paulmck@kernel.org>, <nik.borisov@suse.com>, <zhenzhong.duan@intel.com>,
	<seanjc@google.com>, <rick.p.edgecombe@intel.com>, <kas@kernel.org>,
	<dave.hansen@linux.intel.com>, <vishal.l.verma@intel.com>,
	<binbin.wu@linux.intel.com>, <tony.lindgren@linux.intel.com>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 11/24] x86/virt/seamldr: Introduce skeleton for TDX
 Module updates
Message-ID: <abP/2nPh9qkElV4L@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
 <20260212143606.534586-12-chao.gao@intel.com>
 <31936a20-929f-489a-9dc6-0f8fcb9307f1@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <31936a20-929f-489a-9dc6-0f8fcb9307f1@intel.com>
X-ClientProxiedBy: TP0P295CA0058.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::17) To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|BL1PR11MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 405c781f-bd8e-4efd-bd6f-08de80fa3ae0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: +Py91kKzsqqI9imsjhJy0afCHVMwwY4I2UC1rEbH1OzaQN9NRjKFcEn0RKqY4Alieu4wTxNh3G5Mjy0NIBySHjHmGYURxViKq9uqlmxJ5ujyeOpLO9aP5UBVerUemYAZG3sdZYvKIBaiNA2MXH+K9gEc7WK6L6HGQ68SoLAxqtW//g7is0JfssKJ6FdJfdG0d1B1OFoCCXJXC2oSobO/okgbvTbgz80WblP2BWC3oCD846DAy4Ma2SPNhGGEDxNAPE8/yraA1yobtAj9MDXcxhXeRXKysNuj7ON1VicnF7F4s2Q/0SumvaBjQnjI6NV5Xnc4rG/XBUdXQeiMjCWPZYOjkl95i9kN1yJx6hedXuJwvsRgM3fUQrh3Rz3vsDxHtJFPIuuOegLNae6+ZYixronkE8UbX+Wz9b8Tv+0FvJbLPEPCl4B/cgbkxLHEK6w+9TC9y9+2uFB6JtmWDLuNYUq68F2gwYxUP4+5d0x3jSby7tnJCZg/wPluE+VXqvzoIMxKTL6WKianf0gN+ahPP0E1w3ltQquPTtTnBYDUWsKeq83ysz1/azwU00JK0ffeb4NsMcVd7R7kqB4IB6bK23wRUvajhJJ3ltsYtrstWcP0J6n7WV1N3DeX+RAcsAdzvwQQXwMlsGQlHEU9wpQcJ8NuhLkj3CdNcRzsLI27Kriw0vOVE5O4b2dtXrMU8DrBqjeHRULBWYvC6B0ejUOzNL5/MTlH5Yf5BQ13/7rYLTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zXFaY2q0d/RNJoRX4mcQFVGJH0T99qkk5KDMHR8qVltUnPOQJyQWr/jJF59S?=
 =?us-ascii?Q?omJ0Q/rLnKFrYI82/8yQnme14GISSAdCeeGi98wff+K2EheYmhL6ZqVxyOrz?=
 =?us-ascii?Q?gqKeReIkTr64ivMkZji5KqmDPTCfhnZZDsenfZe1Vxth5UiHsvYh1bJqDqjW?=
 =?us-ascii?Q?v5+fdco3UFYPiucNABMdUx6lPgXrvNfHBJtm7br5Q7k3+ZZtEBuCZb0zBypT?=
 =?us-ascii?Q?pQB/3bpBpggw9bifFgamDSVV+f20gCqjMcgAkILfWWzA+w+z1457oRgt2vDl?=
 =?us-ascii?Q?PRVPjZ4bdU3u9Q1pUP+DN/EsxTIQMFjTvZ2aH/GE/sGnq4sv64wIPTCglEIX?=
 =?us-ascii?Q?0NhTqhTwzy8YS46ERHXQl5vcAH5RGfcpAc+8DCFwwJ/0o/Wf2cDgvNZ9TIds?=
 =?us-ascii?Q?pD8R6d1ZPfe9eG2i+zV5slbEm3S5z31gura+pGRzdZZkNT/7de6eaPyV7XJ6?=
 =?us-ascii?Q?yeKIAmSFP8dnmSR2++s5kxl8P1REmuERrRxLIYBWKluKEGFurAIuEdYrnpHT?=
 =?us-ascii?Q?nMMBJ2vH3URvQP17rIhkxOh1xr38HC2COpVXRYMrOUWo5SJNBiAcdCJHkCeD?=
 =?us-ascii?Q?4sPQ8FbZ18QxvA11mwVC+Q9K5jgSaiXNoiZE5A8curBSIcAyklXdMxfFCAM1?=
 =?us-ascii?Q?H8ZAMHPE5ZIKbEAb6U/WZRanvkmspinxfPJKrPPa1Q9VV/RrmanAIdTf3n+R?=
 =?us-ascii?Q?qD9yNzt5LCIbua2ecsu/5M9oWATOVjWfu3fLZ8RO9mZGV7sCDuCde1YqNnNY?=
 =?us-ascii?Q?tQ8YdzmBZ9XO1UiadiOMzspL+nwPOSm5A4eOLfirqosdwriUTrdo5ksHkICX?=
 =?us-ascii?Q?6iFVzQ5WkxEnSBe2EVunq1IQMHRw16w/NoijT9CAH7L4G9ne7OM1YMNzsKoc?=
 =?us-ascii?Q?Q4UVKuXcTCfAYQEBCnhVoa0UErw+9Q7KWrNmdODWXOsq74/cY0IGXfKLLiRz?=
 =?us-ascii?Q?LEBIKS6xTGbvattmLJfCBZNre/zVzwcL5OkzNQxnj69Vi4jYiTV88VEgH70o?=
 =?us-ascii?Q?JsLgHJCiLDW9MzYDYYjZQ1HThk65oH8/xifoEjP2oTH00pDIrGzAi+K/aPgF?=
 =?us-ascii?Q?zVOXOW5Fyt7/NCuW/evgdrH+HGdIEMMVsAaRdTqYG6shYX6ryQ8gJlwFo6Qr?=
 =?us-ascii?Q?GRZVv2OYtDkSUVhZz2RxYGGxIU1lQYtCpN4RGzS3UXWrz3bFgmSkigd9XVlR?=
 =?us-ascii?Q?fD/s/UNUJFGGWfCX6vwVwJYqs1SDiLJa53Umk4NWqaTPbCpUrNO5kOEwZAuF?=
 =?us-ascii?Q?EJFSMKA9ITyo5eI8PIBTMx1TcGq3Hz94nSoR2jEsT2zlUF/H4+WPRBq6FdTH?=
 =?us-ascii?Q?ZmzzJGXL4hOfz5feCYiZTJvwXxfTn2ic7zUhVbzd/PbTOiADKp+TZI9lPqRu?=
 =?us-ascii?Q?1D6LjnlnRgVvT5JyLr9X1ZKrqU5ztWthkcpXSk9chFzjGkOwo4XehcxnB2Rf?=
 =?us-ascii?Q?LcAkNNgVZegV6NB+H3oX8Z45/2LfAeuRWTQgnJ9is5yozRMftgZPEcAX7ScC?=
 =?us-ascii?Q?RL/aBQ0BvCf0pFPdFZ5V0MCpXHbrXHgTr32V/FnrC5ozpIiX26+VxI+JY5hO?=
 =?us-ascii?Q?b7beqJItn5A9nCTa3wN2U6NtILzDdA2+omC5Q/1D/yDocS+ouWEp6y1siZt8?=
 =?us-ascii?Q?AO5pofhi7cJmC4SNDM24DthWhLmqCcBLWipimHNtRyBMgcZIGI0mRfrq9bTf?=
 =?us-ascii?Q?+qjVyc2Mr1jAyO2yPPKFTdEefzqf1UDUWgQkzsnxElVXE+qTeBDAPT2eZqDS?=
 =?us-ascii?Q?XHjPp5B2rw=3D=3D?=
X-Exchange-RoutingPolicyChecked: Xo2JG+fY0rIM8fC+RfpcYqEqCRhBsUP8l/fZJuOG1E0CIw57CWtDxVouvCtlBhr5WSsUqVlEq3IhhCmcTyAEVdrNMu6wmsFbpihuMSiKOslQXeMGhbfQBjtxCHsrEu6CHnyv1Gc0NNjYVpw2MJA52joTWInCKeQw8cge0inHFBbfvfVZC3sv9BryYb6JSXzqruyK5P4BNONM9zyuoOrVtgtgDTsR/WzWELqI+qKxcHztbjDo+2nAx2fv01An/NwjETQsa+fRJOHpHLdbQ5/if53CUuT52dyEUr9hbuEqkw1e333nEJl0RqUrqXl7PA1lYBM2zBbRh4lVlUU4uKPZyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 405c781f-bd8e-4efd-bd6f-08de80fa3ae0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 12:15:35.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/fJZzxI9hUC0UCXMZSBvGL6WMALOCFRDYD/WSZnTjW96arLBQp0PHpCV2a9e5in/MbEmrL5AtO2ycv3FyZ6tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6050
X-OriginatorOrg: intel.com

On Thu, Mar 12, 2026 at 01:40:44PM -0700, Dave Hansen wrote:
>On 2/12/26 06:35, Chao Gao wrote:
>> +static void set_target_state(enum tdp_state state)
>> +{
>> +	/* Reset ack counter. */
>> +	atomic_set(&tdp_data.thread_ack, num_online_cpus());
>> +	/* Ensure thread_ack is updated before the new state */
>> +	smp_wmb();
>> +	WRITE_ONCE(tdp_data.state, state);
>> +}
>
>This looks overly complicated.
>
>If it doesn't need to be scalable, just make it stupid and simple. Why
>not just protect the whole thing with a spinlock and be done with it?

Good suggestion. I copied this from multi_cpu_stop() without considering
whether it could be simplified.

Regarding scalability, I compared the update time and didn't see a
meaningful difference on a system with 240 CPUs.

I will make changes like this:

(Note: I'm also renaming tdp_data/tdp_state to update_data and
 module_update_state for clarity, since "tdp" isn't obvious as Kai pointed
 out.)

 static struct {
	enum module_update_state state;
-	atomic_t thread_ack;
-	atomic_t failed;
+	int thread_ack;
+	int failed;
+	raw_spinlock_t lock;
 } update_data;
 
 static void set_target_state(enum module_update_state state)
 {
	/* Reset ack counter. */
-	atomic_set(&update_data.thread_ack, num_online_cpus());
-	/*
-	 * Ensure thread_ack is updated before the new state.
-	 * Otherwise, other CPUs may see the new state and ack
-	 * it before thread_ack is reset. An ack before reset
-	 * is effectively lost, causing the system to wait
-	 * forever for thread_ack to become zero.
-	 */
-	smp_wmb();
-	WRITE_ONCE(update_data.state, state);
+	update_data.thread_ack = num_online_cpus();
+	update_data.state = state;
 }
 
 /* Last one to ack a state moves to the next state. */
 static void ack_state(void)
 {
-	if (atomic_dec_and_test(&update_data.thread_ack))
+	guard(raw_spinlock)(&update_data.lock);
+	update_data.thread_ack--;
+	if (!update_data.thread_ack)
		set_target_state(update_data.state + 1);
 }
