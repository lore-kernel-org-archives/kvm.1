Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC43D75C5;
	Tue, 21 Apr 2026 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784295; cv=fail; b=VIZLYaJX0c+EZhhc9liDk0Ajot8N6kkhLQy6+Vw2h84wmo/kQsdL5uKK/mubLtgek3cG9jzORagrPjozebkHHuMHMmOthWTnCwW8srlfiNlSyU3t2T46/aTcR0s5HEbEBHSu3q3pI5L1AQyqMW8OOO3gleQEbWMSQPidDCekK7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784295; c=relaxed/simple;
	bh=xc5Y2YY1EGsuzc1Sp8M4kumKUfF8KLM1NxienoTui74=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KUIRw536s2OhSh90Ht2y6JZIyzdUw39E5YjkTqwN6H+a99dhyVA9iRzk1W/y+NkyYI6c9aUNDI+k1sJe8/0JO7MdRzc5md0GLAiSqK5lY8pMHyLoDZlpNAzRXiLt+1hnoc6jZcGlyrh8Sxkh/wRWqDy3PQZI6gPhmMCA2Ety+U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWPL7p5Q; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWPL7p5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776784294; x=1808320294;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xc5Y2YY1EGsuzc1Sp8M4kumKUfF8KLM1NxienoTui74=;
  b=GWPL7p5Qzv4CRdZbJn16xrZZuCzw9pG6apVb2oEm9Xqn6ugVy7zpwAtX
   C6agCVfCOGPFfLP55YxVzevTGloTUYP+gyZgZzelJ852bK+Fkq/KL4Qw9
   r5LVLCkhX+vYdUJ7xUcNGHjuVrPP3Q7migIzwkUHdyZW7P2X0emR2GU7F
   EZFIGqJGgBb85Mf+V2UDsB4KHfIdHFKghn/eEPDMRhT9LUIUU7Dnc++mc
   0a5ScAb7UVRCOETEnBHuEIzmGMzJmlBoNTMp/ONFS9SDn3Rc5y6tbz5ml
   pH274aPug40ol21IhzWSxUKZGKBCW8qeRTIyEzWciTdYZNZvdsAR99RbK
   g==;
X-CSE-ConnectionGUID: 0NnvbSyATPaWyF0fRqrgtA==
X-CSE-MsgGUID: I7caETs1Q7m5ABaoSviKFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="76753209"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="76753209"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:11:33 -0700
X-CSE-ConnectionGUID: vgQU7vgCRZWpndYuZ8+T9w==
X-CSE-MsgGUID: Pqe1op1XR5KSjy3BDWeoJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="228896957"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 08:11:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 08:11:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 21 Apr 2026 08:11:31 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 21 Apr 2026 08:11:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfTyejSH4CjfsDUNdxFIM6lk7dAQHkz98t8HcvtNJsvtV6GHS60Z+PHi8rt5bYDxXObXp5zrDm2xBtXFGx3zkSvv5o+kfdtoeVj88ZSAUQ9d6Fk5Uhhik5TkmT8M9u3eKK49eA5uEqW7VNumJsvj4I9avAOgzcYcHBpgXT5WMX1AxuIj3GUB+3RL8SMbFn6YDyFOrJ4DYzAcCqN7v6NYF6DZ1vafE5aJ/xVUtTKyhMq1TL7QS3FYzsxpzJPIfeg7syndQRtCbxxOtNfbsuRjWoFNLirdUDb7jtKRFNUzQ4zHDHFha6K7xAN4/5KVUTNPDk+rw9CGweZmv9VmWuvxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMTQSqLZZP+L7/jkn95vbO03oBRmYVRp6IvAXbIOgHo=;
 b=JZ6OuCmVWtonRVSzO9cTy5SFnhvs8/bwJ35Wuvq1pfzJyzVFhgdYfAxGJVumV2TDRzKmG38ZPCUEjv+R7RK6tAKjKlNYRiSZhwyeO+/k+JDL1GU4xo2i0QHB5x8SSyT02LgBHveSGx/0MGYA2UYVfkOpYTBbQcWFwKoHk57txZDSjaFPUx5li+qdZ3RTkE9h0vQyujgJucHKPLzJZO5ReHWAI/QM1Lmt6sh+3UWO+kQaejcpkjJZ/+SSZfGQyTKJhn3c32II1tx+/sDDr1EAeoh5SnYif/p2cm+HZ7T62WBaa3Y33vzzFlzjrqb1YoFugDhjsR+WBmAaYdBem2A6ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DS0PR11MB7409.namprd11.prod.outlook.com (2603:10b6:8:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 15:11:27 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::3454:2577:75f2:60a6%7]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 15:11:27 +0000
Date: Tue, 21 Apr 2026 08:11:24 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: "Moger, Babu" <bmoger@amd.com>, Babu Moger <babu.moger@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "Dave.Martin@arm.com"
	<Dave.Martin@arm.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "bsegall@google.com" <bsegall@google.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "kas@kernel.org" <kas@kernel.org>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "pmladek@suse.com"
	<pmladek@suse.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "kees@kernel.org"
	<kees@kernel.org>, "elver@google.com" <elver@google.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "lirongqing@baidu.com"
	<lirongqing@baidu.com>, "safinaskar@gmail.com" <safinaskar@gmail.com>,
	"fvdl@google.com" <fvdl@google.com>, "seanjc@google.com" <seanjc@google.com>,
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>,
	"xin@zytor.com" <xin@zytor.com>, "tiala@microsoft.com" <tiala@microsoft.com>,
	"chang.seok.bae@intel.com" <chang.seok.bae@intel.com>, "Lendacky, Thomas"
	<Thomas.Lendacky@amd.com>, "elena.reshetova@intel.com"
	<elena.reshetova@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"eranian@google.com" <eranian@google.com>, "peternewman@google.com"
	<peternewman@google.com>
Subject: Re: [PATCH v2 00/16] fs,x86/resctrl: Add kernel-mode (e.g., PLZA)
 support to the resctrl subsystem
Message-ID: <aeeTnL3aisKgPJG-@agluck-desk3>
References: <5a273b0f-8225-4e9e-924e-884183734659@intel.com>
 <73c46024-4cf2-4f03-9268-d4378825fa87@amd.com>
 <973067bf-6e6c-446a-a81a-713840d701a9@intel.com>
 <90f4a692-1c27-4967-bf12-ec3cb597681d@amd.com>
 <68a551ea-d9f0-436a-9bef-e35fd027bb95@intel.com>
 <39e0c786-cc35-4555-bfb9-ff7cd758c423@amd.com>
 <b74cfe34-e23e-49e3-beb4-d5639d42d5cc@intel.com>
 <99a2da36-6a21-4a99-98e0-3c9a4cf7ecf6@amd.com>
 <aea-wdaZAWl2Al1h@agluck-desk3>
 <58b8fe0c-80f6-4ba2-abbe-90d0ceee6daa@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <58b8fe0c-80f6-4ba2-abbe-90d0ceee6daa@intel.com>
X-ClientProxiedBy: BYAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::20) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|DS0PR11MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf25305-4ab6-4417-1306-08de9fb84268
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BhNjda9vfuh5+qzGXFSQ/kZh+DcBjHVWV8314JgoRvn7Pq3eWVnjuqRvqLGAmS+CsB6qO6jbJBDVwr6V+rg6JDoD3imQiduGDq7reL8fl+Fn8a157AWEWiyp+WsVMfxNs494rzJfcsosrp+enJ1lifooHqxBKW0VhohAfHvL/PxWjLc5zHMz1HLrTKkER/wd4UJKcTd8op33LpyC3ZfaCFqgbh5uyzoevGFqo9/7uFbF3NanKlOAe+aiBjZRcLWlgdtriP62Qiw4jVcr/4k9c7/q8jfnnP8I9lri50SDWkEflYINEr9vA/yijc/pGOGDWdqp6EO1KKQSGoHhosnLy5zaXgseCY3LWcwWsBbbQh6JgY97KB/5crFg1OvqQp5mJBk30pkRXznArwciF2FGyYWWO97P4ny3dU8HzrkzjmHLI95GXnOK2F+zS/+95AEOd9lYbW8jgMWeIREXqG4Xwn+jxOGLURabZG42K8xb26NXxKQ700mKAc4TAdR/Dh3Cp8tI0Rzi//8IDsnrZLns/mRqYaixXGpndgZ20bOHmCzkiZESSLNiOJaJLSdgMWOSnzYyt6QWW14H4TKsU6ViY9aPzmsgfuXA4IgpPeY92/PpjctSGK4pfTG7U63vmkIWohttsknqlCxBsTFlcS+OZfa/kuU37SECOfIlTK1xzmfNyVk3sfxPuVo4O93/eJc01D2OQirij+40TPjllUwSxOo4V1dLYrK8XlRh2GpNz0w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybNZcQtk4g6JZh+z26Y59KE8UnxvsawMoQif+pY7tx9ZhrqbBftwRrkrIgoW?=
 =?us-ascii?Q?FS88XLgcGjshLZxREGdRZa4qqRZWvmh0xSMHvbtSUSLZmosl613mX63RMjtU?=
 =?us-ascii?Q?hA4BvYWCMNvwUfuLd6O4rnrd14uHYgfHspIgyN7PMl8Z/Kv4v832Z2zo3bMN?=
 =?us-ascii?Q?BLHHOp2sPzRVYnVq3crSiq9hWxD3x6NnztYpE5x0XTEnt866t1N7HjESZXFp?=
 =?us-ascii?Q?ylO81mKGjWw+TK3Kz+jMwLEtuEd2u7G8tblixagY81sVQdXuXqp3eQiN/gO2?=
 =?us-ascii?Q?RY+80tLp2/FnHp0k38KprOXtdoIqNiQUVy3r1aFoAL2l/qJ1PAty9IsIGA4G?=
 =?us-ascii?Q?Wa+cRPX3f+Hub3EdGyn0rlX3Il9iq7PeNECxiSqdyIfeoY3hWYY2J/5REbI4?=
 =?us-ascii?Q?OMEKadxvHJxiXNlXikyVvZfe02qc5QlajCgfcS0gpQydjzl/JsplwrVy7pQu?=
 =?us-ascii?Q?bq/T5o9am9uAEJeB9EAgqhi3caVKXg+g4ThhOeYS7YdfnK/XBPxkT80bYR7M?=
 =?us-ascii?Q?7ZQN6IhjcuPVWdeA6B4lUvyc4jv/81wFw4clzKhtmI4D39iKDJc4ccBJ7l1R?=
 =?us-ascii?Q?SlxODQulAnrvp4noFjqVCoh2gmjKzQvSj+9r3DdQpW9E7UXwh/GPzPyBSXDk?=
 =?us-ascii?Q?UXN+/GAUabrOlsAjBVBC4VdrOdX9vlTAqahhzY5bT9ITaPsQ5v8zkI+Zq7iw?=
 =?us-ascii?Q?CiZAMfoRaQ9w6z6sjJ3I8AUYYv8cL27bDvI9Taxsl5Asq2zCAf0bFVa+hbZU?=
 =?us-ascii?Q?3tpqtejfYfZJfjFJyeoGufpLFCh43W9Yo0i+LtECRI0v2gB23ImXSalXtxhZ?=
 =?us-ascii?Q?dvvldzLvCqsCL/Rng571rrnzBB0hrjowzGxbWcOiX+QfY1qmx+EQlE81ZLLa?=
 =?us-ascii?Q?WO0+8u26iVGTXjZ5OJTaYvt+xZuBYNUMayBfxUteAfgN4wY1I+Kjjg6FTxYw?=
 =?us-ascii?Q?B489kJi67djxWChmNUGa02Lp4cL9nl0HB8A3c8yhzpHj2aFYXSyoItET8/km?=
 =?us-ascii?Q?yu+2Bbwga9MoA+PTm5eoD+6bLshjavRKl4KNkx3H8TWqSF2sgNVt7aCW2meI?=
 =?us-ascii?Q?YJaKNwgWO81wKv4wlxsqAq9FoZiAf47a8pATVKJHw8JvEgGxbAQbvxAkkduc?=
 =?us-ascii?Q?2btmv9YEmqjNUyj0U4P7XukkpdB80SBxmGQmP1uVuUjM2f3284M96yVRx1AN?=
 =?us-ascii?Q?IX1c6n2MDTa/1DXU9uZXhk56/8qvk8vm1KX8dCiJ9k2Rl7z3954qGufdHerN?=
 =?us-ascii?Q?YG/tHkK7uN6mqhwtY6aNsqWQC4Zsw9JGO7SXc5IiAl0n8fP0f9+SCbRk9BFZ?=
 =?us-ascii?Q?PIx3RnSSswodrW/2Tzm1S94MEwfEhbBEyjagLBlErrDKjTSJhY0pf6ir79uA?=
 =?us-ascii?Q?5/jJ03tGvA2sonlnZ7Rpog4jaJwtOvBK7FzXVpb04cri0/ZLovzDY4ifvjy+?=
 =?us-ascii?Q?4qekeRaw2ag+FYDLb85iuFE7qMY/0H50DlbcaI+UO9KL/SGAkWo2opvV2Ryd?=
 =?us-ascii?Q?7h5pisYJfFNpAKW9fa8VAAIAd96OcslIc4A7KeYnVEA5ftJkK+cmO62+Sp4D?=
 =?us-ascii?Q?ce9CLZvece3jX5QqPClNy/iQfvIJSJ+t0J3zwuMrfo0tT/ho9Qd/djBkZ9qW?=
 =?us-ascii?Q?onzSZgslQtR/6BrHeZAMo4kNglnuqJ8FVxnmugDgoEZ5eOVV77A1OoCZxW3n?=
 =?us-ascii?Q?a0nGQGo6MIrOMEFwaT+R8HgnCAy9qmRR0pFxTDl2GH+TemCt8im1R44y69i7?=
 =?us-ascii?Q?PBhPLJdd8w=3D=3D?=
X-Exchange-RoutingPolicyChecked: DjYTyUo30RX45TDlP0SDCXe3/ioeZYqA3oLfMq/c21WG8hgCNGHr3z9ZxDl3Uj/zHoUDyPzpvr6bxXvoJlZVdKPU7jY+hy33GZ/qPXRlasye3yCOSV8JgsOquI38MJ0V/a+jsBNYttwPKzaJKetv5f6V2VpwITxm36a0irHRUrkAIcL2P3W5+e7h3ebiqL424j1nLokorduY6eRxnCX3LWbye0tPi8/rKzV5jTgZuVe5EE5uQYJqSKouYqClMy2FkBNLssD2vMmcrN5rAK52PC+vsOytr1dCUNZl9XZKuyL7sp8ZLJOo0k5I0IWO5c8l+x5EfOuCtFwRkLtqJ1sgig==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf25305-4ab6-4417-1306-08de9fb84268
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 15:11:27.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1K6QvRm1dlQAMI6NciPoMlb3U+r6M5khOdEhIQugTUet1UaKfm79WXiaOhPdc9B9w4DkZeWXq6GSi/rjEDOcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7409
X-OriginatorOrg: intel.com

On Mon, Apr 20, 2026 at 05:21:50PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 4/20/26 5:03 PM, Luck, Tony wrote:
> >> The system boots with these default settings:
> >>
> >> # cat info/kernel_mode
> >> [inherit_ctrl_and_mon]
> >> global_assign_ctrl_assign_mon_per_cpu
> >> global_assign_ctrl_inherit_mon_per_cpu
> >>
> >>
> >> At this point, the interface info/kernel_mode_assignment is not visible.
> >>
> >> Next, lets create a new control group:
> >>
> >> # mkdir ctrl1
> > 
> > This allocates a CLOSID and an RMID for this group.
> > 
> >> We want to designate this group as the new kernel-mode group.
> >>
> >> First operation: Change the mode:
> >>
> >> # echo "global_assign_ctrl_inherit_mon_per_cpu" > info/kernel_mode
> > 
> > This mode needs a CLOSID for PLZA, but doesn't need an RMID.
> > 
> >> At this stage, only the kernel mode is being changed. However, there is no
> >> way to know which control group the user intends to assign to kernel mode.
> >> All we know here is the selected mode.
> >>
> >> After this operation, the info/kernel_mode_assignment interface should
> >> become visible. But the question is: what should it contain or point to at
> >> this moment?
> >>
> >> # cat info/kernel_mode_assignment
> >> ??
> >>
> >> Next operation: Assign the group
> >>
> >> # echo "ctrl1//" > info/kernel_mode_assignment
> > 
> > Now ring0 code is using the CLOSID from the ctrl1 group.
> 
> ... and user space tasks also continue to use the CLOSID from the
> ctrl1 group.
> It is up to user space to decide if a group is dedicated to kernel
> mode or not. resctrl does not enforce it.
> 
> > 
> > But the RMID for this group isn't used.
> 
> RMID is still used by user mode that maintains existing behavior concerning
> this group when considering its tasks/cpus/cpus_list files. RMID assigned to this
> group is just not used for kernel mode.

True, that the RMID is used if the user makes assignments using tasks/cpus/cpus_list
for the ctrl1 group. But they might not do that.

> 
> > 
> > Are we OK with "wasting" an RMID in this way?
> 
> How do you see this RMID as "wasted"?

Suppose the user doesn't assign tasks to the ctrl1 group?

Perhaps the resources they want to make available to the kernel do
not exactly match with resources that they want to provide to any
tasks. In this case the RMID is wasted.

> > 
> > Maybe it doesn't matter too much for AMD as you would just
> > avoid assigning any counters to this group. But should Intel
> > get around to doing PLZA-like functionality, that's a real
> > loss of an RMID that might be useful elsewhere.
> 
> Reinette

-Tony
