Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9A2272E56;
	Wed,  8 Apr 2026 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664237; cv=fail; b=l5BhHm3SSFj7D2a0Jh0tge7j5Kcn2S7LVRPlMI5kceEdAkXGFBama8fatgYVoxTlgGdeGsKksojNHC6Lp96ngKTVDDW1qFjUr+agrWrCUfF/h0Kub7/3seo8CIlBxqHlC/w5ycMERmtVoWr/lGvDQs7s4RV+CjumZxjxgmVRMwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664237; c=relaxed/simple;
	bh=tN0z2mrIfXGXcFZMjSRqkWUSo2srUYVC8v7XNA/1FUc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GoV7q5PLKGNcwWxnUo7oPbLUym+hJQkn4ulXiL0LyBDBSqPuIL9v6JcPj3bW9SGJZIpek+CYgYnXVNsLqI9M2ShNZVDoKHhfgvxgApHbLnZw61Cy/sqPijYhphEks//UWoI1Uiz1weRon6G4I+fTiNJYdaZIjL/cge48WdbXKJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJK2zRUi; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJK2zRUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775664236; x=1807200236;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=tN0z2mrIfXGXcFZMjSRqkWUSo2srUYVC8v7XNA/1FUc=;
  b=YJK2zRUiiAct2XLBM9d8ICWCX/iTuziDLB4+P9AOVcsX+qXocElHqJWn
   PYMoEcNJ/6Gzvi+kacPzSjgB3gnH0GbPQJZgIgbyv4jk6ZBNy5FCmd1CL
   9Q8dtvFOZ2AHn+Q1nZl4AxOm91IEuy4eRpEq4TFJSXylHsBhRbK8LXSzq
   MWbvTfidTctDGX9XpHGoYhmnyTzQMWMIPXuYlvqf8J/67tSB0SLA9pPtR
   DsuI7N2oa+CVseZ/8HGu0/izD6zJITWSITwqKDQnf/sJQW0PoC1HvbNZo
   UW+9GU576g75KT0VUyo20VdLygYds/fDjDEIto97KI0tfb801a05L/vYX
   Q==;
X-CSE-ConnectionGUID: aHy8b/DjQYW+X45TQHEGJw==
X-CSE-MsgGUID: l7D47/YDRrSkPfipiS/0Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76530916"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="76530916"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 09:03:55 -0700
X-CSE-ConnectionGUID: vJ+5dkrZQkGbFIWETo/BYw==
X-CSE-MsgGUID: eJU869kPQpqeV3eYznwE8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="266490974"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 09:03:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:03:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 09:03:54 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 09:03:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7LMrW/uh0eYtWyrpuYpJVf0xGZadjFHpuThA9HfKgMEVRvRVgUJXSxVQeK+YjIkSWV8vfU7/MEagJBXRAXCJgGspqi7hI/w/rrMmutSjvYnw6nMVL4ZR4KC4dHl/jGCRTCO9/nLGcCJBOvFr5I476u0PNTKxito6T7uuRNfN+lQ7ce1Y9y322N+maA0iH02liBN+BSOmWtfGsLadEN1ofQAP4GSVVT0j+6EYJNzRgm2RFoKPnopm6CKpXsOMxHb9PwUATnBsDlAAU7xrupFMtVP/ndz+W6LYf+ZLARtquFy6AuowTnufLzSiDxk50w+CzFI3NHdKtqWeXVT6CXDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1f+D45ifdFVu5zHcZsvHYFTW2rnbxMyGymtgQPKwMw=;
 b=RxCPwLZCMdJ1SOv6MckiuocrUR/ObLfN6WQ1zkBN9RCy5ARtCeZ155QVCj2uWTqkQYfcLJUfH3F1lGOpvMe5Sx4YCVvP+oTBtOCIXxHbWiZVuao4N73AjrZatoUOkUsPdP6/UUXL4v6xxs+2zfQif1JBfsCvNqASQsA87gv54bWamXeV7LhcOmSH7sdHGqFHiUjr8TkZy3j4JVTb58n+PQ0lC41uvsIpLn0nbFcBnHw+dTFJbESMgFO+oE2K+pMqw8L+NooZNeWimm5ZILtlOrDOvsMJ4Y2u/mZiIYDzBhwWgsdzSDQuv/c4LezojG6iFn93tUDgiYfUJ4EzJgHHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB8132.namprd11.prod.outlook.com (2603:10b6:8:17e::13)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 16:03:48 +0000
Received: from DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac]) by DM4PR11MB8132.namprd11.prod.outlook.com
 ([fe80::22f3:a01e:fb45:57ac%3]) with mapi id 15.20.9769.020; Wed, 8 Apr 2026
 16:03:47 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: Alex Williamson <alex@shazbot.org>, <intel-xe@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	"Shameer Kolothum" <skolothumtho@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>
Subject: [PATCH 1/2] vfio/xe: Reorganize the init to decouple migration from reset
Date: Wed, 8 Apr 2026 18:03:39 +0200
Message-ID: <20260408160340.866784-1-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0260.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::33) To DM4PR11MB8132.namprd11.prod.outlook.com
 (2603:10b6:8:17e::13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB8132:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f5cfde8-3aae-41db-8f6d-08de95886ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DkptVQZ+IaGZooeLCv+fygLvhHQMg0yTQ+epDpxlY9RakWzlvPUzHWRtsFVM+8U+B0S+GYjLRni97UzbM1dH84zKAqKlprFLkHFFq2k1Lvqem253i0pzx1TK1fxeo1CMAQ6N+jkT6jgdnqTNLytkE212dgPttOhjltsLs/HKb1+6fQVxANDqA7IOTwDIy4tKg4jqWJmJlFvgMj8tcqhJBfwRBTp66Hf3NnoBOmOJn957Nk6gPM+hjRvvpWYD+EokXV/kO/2EjEypbsrEwJXjrzEph2R8JyXMJ5p7r7juQJVERfdBR9OesEz40WdkE19TxPTFnkfrtiEQOBN5mqN17NP6mKhzmfZK76Zp6QT5bxzAG5DYdf9or1bl5Kg9OCNL8/SWO4/i9n29jHbCrSFnW9pSjafLgakKylt6u48Kqn9XXujHrqoReiaoxpY60DDugD1FH3KR7zdyPjPl0TFGYxL3w8Wh0H7gBKzIX6pBy+xuf0rH0/6fUBLavQ90ISPgOgSxnZ6cQCrXIVlmVpOpnwPiWiizGvkxoowu8mdFKUQW8YXNPb8a3+s90800Bm39rvvSR8DJ5tE5fXzM0iWEI+v5pEP2nTh9uP7Yg+hlgE9gAyhjrPBSSJ5Mffm8D1G+7uKuSyUCAja662lBVQyHLOaOfj6j6ZMs6oufQ+Ze7iBy4MIm5vZwRQ9RIDuLG1yV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdlTERrNm03V1hnSHBPNGhOM2p1WkRxYXlORkpyOWFnZElXYlRXZzFtZDhT?=
 =?utf-8?B?RVp5cnpIZDNQWkU1aWt4Zkc2d3ZJYW90cklZb3MrTjhNQnNPbm5GQmx4cjhu?=
 =?utf-8?B?elZDZzdYVnpjdmtQbWc0cU0xSmJuN205RnNOK25zMnpBcTFmNEN1VHQ4RTRU?=
 =?utf-8?B?QzdMMHpXMjhpa0htejlUd2ZBRUliaUkzUmZxeG9EUlVxOGtiRmFFUkJPUERW?=
 =?utf-8?B?VUlUV3daK0Z2TEhBUDVmSXB5L0FJTHMwbktRVk5GZXBDQng5eEtPVVg4VVVF?=
 =?utf-8?B?dUlSeG9qVFB3MXIzTS9nVVM4REdwWnNZeHdOOGJScWU5SkNsRkNoQTN1WVFs?=
 =?utf-8?B?Z2NXRmQxVDkvaERPNVRHTWw1UncwV2M4VDdOT0puZisvdlFpMVFpZkp1Vm9E?=
 =?utf-8?B?NUV1T2V0WUl6NkNIeFRQYnRRTUswZDNMTGNLbGVzczYyd3prSTB1dzRMd05R?=
 =?utf-8?B?a0t3ckVRQmVVK3VUaE1iUVk5NlpBQjI5SDd3Tk9PamkvV2RqNXEvbVoxRkZu?=
 =?utf-8?B?ZzB4WmxLdVRrV3c5ZG5ibWRmeHpUYWFvcGF1SndEaml1WTE1YVhmekFYR05S?=
 =?utf-8?B?RjdoR3lhR094WkxIbGVla2lHSGtVVFlhSnFZcUFkdXRPY1ltSDVYdXpMSUx3?=
 =?utf-8?B?bHVVUjIyZVZiRGwzU2N4a3VqK3c3SDRYYldqTjFseDBCeWtnVmcyQlhvVVcv?=
 =?utf-8?B?NVN1QTBxZWpMUVJ2UC9oM1NUelVVUlN4b05nd2NVRVBKREhsQlRmajk1cURv?=
 =?utf-8?B?Nk9vSzVocVM0eTNQUTNUNmRTM0JEOTNnVmFUaGZ1T040OFBVbW1HTTRpMUxv?=
 =?utf-8?B?VTZScnluY1d2U1NoTUdDQUE5SDg5UUtvREtyL1QzWEdwNE9pSWdoUm5wZjJa?=
 =?utf-8?B?N0JRODVtTktZS0JNY205LzB1ZG5YbE5pRWp0TkpVNFdnOHkvSG1PK1AreGZk?=
 =?utf-8?B?RVZMNVZIMUNkYWY0bERGNGtuWU1DUS8zTksvMi9ITmp5QjFvajQzcmlvbnZa?=
 =?utf-8?B?ZE1jQkRmOGFMWW14Q29GNHBaUnViM2daajBVdnlZWnN6dGRkWGNHS3RZN2w2?=
 =?utf-8?B?T2JCaUs2a0JLYWNOS1F6cnczVjVrcmdaWXNBSmtWUzlzcXBRV2prS1dwL0lt?=
 =?utf-8?B?VXBSeTQvRlZBbTNuTUhWdmdBZXNVd1VYbUt6OW92OG1hWHRIeXVkN2JSNTVN?=
 =?utf-8?B?RHJKVlhCK09mN1p6dFVqclp4SC9TbmhDNFNZNUxaeEdnRks0SElrbnBEdE1S?=
 =?utf-8?B?TE1QMEZEWHB1aXFXN0VmZVFLbnRsVWt1LzVJNVQ2em1HYVlsTmFGNzFkMXdP?=
 =?utf-8?B?NmplbDh2YzR6aU1MQ1Q0NTlsR0JJcHZDejU5SXRIN0hwYzBhSzhhZ0Qra2E0?=
 =?utf-8?B?ZzhhTWhsTml6YXhWeUowOE43R09vbnFRVk1xQmJJK21DUU1PY2k5d2ZFYjlw?=
 =?utf-8?B?R0V6TDNvemJCSVJUVzNFT29jZitMaVc5ZHlXK1BabW5CWHFvblZKSlg1RmRJ?=
 =?utf-8?B?T21TTkpUcVVSM3NBNi81QmxWVWlWTUl1SnVBTW1jREdVY2ZaODVDNFpTOS9a?=
 =?utf-8?B?QTNpMGlkRzdpYUg2ZUk0THFsNnlkZ1VUVFk3MWdESWZRZGtDR3piUmdScnF1?=
 =?utf-8?B?bXVHUExXTlBGdFB1dU1TY3JIL2w1d1NtWXF0VWVjS0xhWG52c0tEWlg1dmFs?=
 =?utf-8?B?bmJRcW1veWQyS3VrWkxuZ0dWVDVBRlJGTGhRQTRwdWc5UitjYlZaT1Jabisz?=
 =?utf-8?B?eEpGUlQzUXhUeDluenEvZVVJaGlHUHJwdHF0S3pIdjkvT2xEY3BJY1BqcFBH?=
 =?utf-8?B?TmJXSVBqS2IvdGNvanZtd0NVclZrbTM2Y2hhazdXTmhlVXowMlF2UmZwWDJu?=
 =?utf-8?B?VVdCVlFQWUFEaEpPMWQ3NG9SZktwa0ZpU1VMZmpRYllIbjFwREl6Z0g0eW1y?=
 =?utf-8?B?Zzh2T1FmalVUZUw1b3IzOFNlNGl6ZytZME00WjhUQWhCaWgyc3hUaVFBMkZr?=
 =?utf-8?B?SERVeCt2NXlZcFI0R0JBNmlyNUJ2eklHQjE5UTBoamlJMmpZUGJWSkxMQm1G?=
 =?utf-8?B?LzJYYU9Bb3NIMHRJc01CMWpWSUxXQ2ZaOC93MVk2K2xWOFBEbDQ0emRraUxQ?=
 =?utf-8?B?OHlnVVg4QnROYzNUbmwwVTNJZDhsKzhDaGFRbStISUJjZXE5eWZCUDFGV3FI?=
 =?utf-8?B?UWs3Wi85UzE2aFNYV0xKb1RPc0FRY2hENSsvaDBUa2NnRHh6UTFoVzFLZHp0?=
 =?utf-8?B?b1FyZDV1R2pUb1Z5Y1g0cDZzWXY0MU9pS0M3ZjBDM3N4NUdIbDVQd3hFUjVn?=
 =?utf-8?B?YUwzdnpBei9GeWwwZ2JHL1ZVTkRrOTlXMG4zd2NUVWZCaTJjbE5TSnJFTE4v?=
 =?utf-8?Q?Ahg0RpOIN/TzSVqY=3D?=
X-Exchange-RoutingPolicyChecked: Vs27YBN70tzHB9p8BZyEEZHYlu8ma97cAyAoTDR2i1ydjQOEguVMFOnH9N6Q1uCFTI+ZITiBOLmsDo8oGXdSzusOCu1AWgIl64IJ2RkstHq4c9IX/gmZi94fHmVfwvL9NR7W1hS/7O5M1kIGh3zYyfy2pzA3Jm/oBC/0fwF/OPam7AOrpRoRj9f5Bk7HHEZG5qgklNPLCGwLxwfZswpO8N/wVib+KNtH1wdHBhmrYRvIYO3mxOmH4F5ix8Avqi6joOMo8qJdNN+TtH9H/Sojqpq7d0bx65mn7la+gc69gk4oMnpWAUJ2fMhBurUtVPsa3IwuAjmphEuOT3+9SjDjkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5cfde8-3aae-41db-8f6d-08de95886ad6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8132.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 16:03:47.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDi3WTdbrrDR6pnTFlPG8zYI+KTLbqo4D58cwcyxIMcm8iyhOeNlbKl6PdRzTmoWKPMPpg+Va0XySf38L9vQs8gXgtWMuykHPgutcSUNM88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com

Attempting to issue reset on VF devices that don't support migration
leads to the following:

  BUG: unable to handle page fault for address: 00000000000011f8
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 2 UID: 0 PID: 7443 Comm: xe_sriov_flr Tainted: G S   U              7.0.0-rc1-lgci-xe-xe-4588-cec43d5c2696af219-nodebug+ #1 PREEMPT(lazy)
  Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER
  Hardware name: Intel Corporation Alder Lake Client Platform/AlderLake-P DDR4 RVP, BIOS RPLPFWI1.R00.4035.A00.2301200723 01/20/2023
  RIP: 0010:xe_sriov_vfio_wait_flr_done+0xc/0x80 [xe]
  Code: ff c3 cc cc cc cc 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 54 53 <83> bf f8 11 00 00 02 75 61 41 89 f4 85 f6 74 52 48 8b 47 08 48 89
  RSP: 0018:ffffc9000f7c39b8 EFLAGS: 00010202
  RAX: ffffffffa04d8660 RBX: ffff88813e3e4000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffffc9000f7c39c8 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000000 R12: ffff888101a48800
  R13: ffff88813e3e4150 R14: ffff888130d0d008 R15: ffff88813e3e40d0
  FS:  00007877d3d0d940(0000) GS:ffff88890b6d3000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000000011f8 CR3: 000000015a762000 CR4: 0000000000f52ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   xe_vfio_pci_reset_done+0x49/0x120 [xe_vfio_pci]
   pci_dev_restore+0x3b/0x80
   pci_reset_function+0x109/0x140
   reset_store+0x5c/0xb0
   dev_attr_store+0x17/0x40
   sysfs_kf_write+0x72/0x90
   kernfs_fop_write_iter+0x161/0x1f0
   vfs_write+0x261/0x440
   ksys_write+0x69/0xf0
   __x64_sys_write+0x19/0x30
   x64_sys_call+0x259/0x26e0
   do_syscall_64+0xcb/0x1500
   ? __fput+0x1a2/0x2d0
   ? fput_close_sync+0x3d/0xa0
   ? __x64_sys_close+0x3e/0x90
   ? x64_sys_call+0x1b7c/0x26e0
   ? do_syscall_64+0x109/0x1500
   ? __task_pid_nr_ns+0x68/0x100
   ? __do_sys_getpid+0x1d/0x30
   ? x64_sys_call+0x10b5/0x26e0
   ? do_syscall_64+0x109/0x1500
   ? putname+0x41/0x90
   ? do_faccessat+0x1e8/0x300
   ? __x64_sys_access+0x1c/0x30
   ? x64_sys_call+0x1822/0x26e0
   ? do_syscall_64+0x109/0x1500
   ? tick_program_event+0x43/0xa0
   ? hrtimer_interrupt+0x126/0x260
   ? irqentry_exit+0xb2/0x710
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7877d5f1c5a4
  Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d a5 ea 0e 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
  RSP: 002b:00007fff48e5f908 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007877d5f1c5a4
  RDX: 0000000000000001 RSI: 00007877d621b0c9 RDI: 0000000000000009
  RBP: 0000000000000001 R08: 00005fb49113b010 R09: 0000000000000007
  R10: 0000000000000000 R11: 0000000000000202 R12: 00007877d621b0c9
  R13: 0000000000000009 R14: 00007fff48e5fac0 R15: 00007fff48e5fac0
   </TASK>

This is caused by the fact that some of the xe_vfio_pci_core_device
members needed for handling reset are only initialized as part of
migration init.

Fix the problem by reorganizing the code to decouple VF init from
migration init.

Fixes: 1f5556ec8b9ef ("vfio/xe: Add device specific vfio_pci driver variant for Intel graphics")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7352
Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/vfio/pci/xe/main.c | 39 +++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index 88acfcf840fcc..40ea73234dcf2 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -468,39 +468,56 @@ static const struct vfio_migration_ops xe_vfio_pci_migration_ops = {
 static void xe_vfio_pci_migration_init(struct xe_vfio_pci_core_device *xe_vdev)
 {
 	struct vfio_device *core_vdev = &xe_vdev->core_device.vdev;
-	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
-	struct xe_device *xe = xe_sriov_vfio_get_pf(pdev);
 
-	if (!xe)
-		return;
-	if (!xe_sriov_vfio_migration_supported(xe))
+	if (!xe_sriov_vfio_migration_supported(xe_vdev->xe))
 		return;
 
 	mutex_init(&xe_vdev->state_mutex);
 	spin_lock_init(&xe_vdev->reset_lock);
 
-	/* PF internal control uses vfid index starting from 1 */
-	xe_vdev->vfid = pci_iov_vf_id(pdev) + 1;
-	xe_vdev->xe = xe;
-
 	core_vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_P2P;
 	core_vdev->mig_ops = &xe_vfio_pci_migration_ops;
 }
 
 static void xe_vfio_pci_migration_fini(struct xe_vfio_pci_core_device *xe_vdev)
 {
-	if (!xe_vdev->vfid)
+	struct vfio_device *core_vdev = &xe_vdev->core_device.vdev;
+
+	if (!core_vdev->mig_ops)
 		return;
 
 	mutex_destroy(&xe_vdev->state_mutex);
 }
 
+static int xe_vfio_pci_vf_init(struct xe_vfio_pci_core_device *xe_vdev)
+{
+	struct vfio_device *core_vdev = &xe_vdev->core_device.vdev;
+	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
+	struct xe_device *xe = xe_sriov_vfio_get_pf(pdev);
+
+	if (!pdev->is_virtfn)
+		return 0;
+	if (!xe)
+		return -ENODEV;
+	xe_vdev->xe = xe;
+
+	/* PF internal control uses vfid index starting from 1 */
+	xe_vdev->vfid = pci_iov_vf_id(pdev) + 1;
+
+	xe_vfio_pci_migration_init(xe_vdev);
+
+	return 0;
+}
+
 static int xe_vfio_pci_init_dev(struct vfio_device *core_vdev)
 {
 	struct xe_vfio_pci_core_device *xe_vdev =
 		container_of(core_vdev, struct xe_vfio_pci_core_device, core_device.vdev);
+	int ret;
 
-	xe_vfio_pci_migration_init(xe_vdev);
+	ret = xe_vfio_pci_vf_init(xe_vdev);
+	if (ret)
+		return ret;
 
 	return vfio_pci_core_init_dev(core_vdev);
 }
-- 
2.53.0

