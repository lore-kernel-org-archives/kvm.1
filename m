Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40CB175A8D;
	Mon, 23 Mar 2026 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271465; cv=fail; b=ZhKGsvw0DM/QCtkbiGtZQX/uq4z6aLw0+LhGC6wh//dl3b7D6fX+BwiX9ZiX3UPO6mOzk7ji2aOpVBwC4RaxDG3A7G0QGJs0UDtlnG4zHDS6Emt00JEsLWTAyr0Os5xLKbdXE7qre5AcdolwBzuVQcKcY0RBDZjixRczavzWmcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271465; c=relaxed/simple;
	bh=q7RXl8Bj2FjxyyuFYD3uDekQd9KrphRzqE8wHYhN97E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=grnWdTjw9BtYvurZyX2BdUJZIaN6QUDhWcNtR++23CLlnaxGAMKwXNXjOSyLdNf+rTjqSx9sJ26AL9z2GlI+xIVY6dDTF09vHOOeub+2HSc/M0NR4XK+ocS/1XwJkVkQ7GFU8P8RhLJ/q4E6Ut6Jd0lZQ30qUt5Ih0DXnEBm59c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q24uBWOE; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q24uBWOE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EC7PWgc0QNPXZ2AVO3JNIzj+ReplWI7NU7hmOhFiDNnsfrc8HrTJhGTvaCTVrO+PPCNV2QRS0vGQ3Lf6hh2AxPJzpfD0qGhb/9Puy7JfCuFbpifoYdu2ATKKXcPfwMkRN/f3iFnTO64f3mSaiAub6c460FxjUw0eD0Wms/WxS8jf99ATNRFFnpvqFh4pn1N+hSh8Ix6yFY19dDwtzN2H7tSkTURgFTgg+LszxNTjpgnXZAYD5O5krQzq6icdSDm+cDu9+czXBDMgSSFnX2gw9JRW4vu6XuFt/ChMmd4FsiPOTZJr4KNCOqlKK05GNLmI2hRfbtREtsyFTai+6RmULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXcOZLIgNYLLwfBkfvtjxpJ1lccfSajU9C+wnJsvY4E=;
 b=I66Ak/1zWF90Ow/KV+xT06gyomxqI4UZv36X/hvzQqoiAmHZsy6kNhsqoxq0ogaYeDro1auH+eOV10iMeBqzHZRIrD7NdKJmUc+dpi0H1H6m+OB+1fyBcw7UB0Eles5eOgRr5LnaDM5U4e1aQ2kOzpJFD+qZd7p3ALAZmuwHxLQeVrcgkqfOr12DEKRYyg17Ud/6eCHuwyelMUdh/1Qm4f9SB2BjJeIymZmL8Z3Rgb+PCu5haLUY/O3bRH112x6woHmOqJXKNDqkGrcYvSEu3/iFPuRkwZsqZdwSGnyX6GLmi2khqSMbIgglO0rTR7qOiKBJ6JK1ge0Fy2t1Y9OmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXcOZLIgNYLLwfBkfvtjxpJ1lccfSajU9C+wnJsvY4E=;
 b=q24uBWOEiOy75Foy0n1n05+0WI2XvaWYtX/qsMlzj9IHVUA3Zl00qfEa5CmstIMAY8H04j72D+7NCP4hZx0+nxaqxmZytuk2R2e/6PPGEscS9GyhrMCNAocUYajTwuydQ0NoLr2JJL8oCDwMxejDmEkQPeVYEwmmFLREuWOjvYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 13:10:55 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::f3f2:852c:78d5:9353%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:10:55 +0000
Message-ID: <647abba4-8d47-44b0-9e11-b3f1d04c408c@amd.com>
Date: Mon, 23 Mar 2026 08:10:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: SEV-ES guest shutdown: linux-next regression with QEMU 10.2.2;
 smp>1
To: "Aithal, Srikanth" <sraithal@amd.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: open list <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>
References: <c820e242-9f3a-4210-b414-19d11b022404@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Content-Language: en-US
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <c820e242-9f3a-4210-b414-19d11b022404@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:610:cd::7) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 41db1976-fdb7-40bd-9f40-08de88dd9d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yBizZQOneeb3TgOciSjH4pFi4yhP7kN65MDfvPnsImQqieRlGT4HEubm7WTeOvmCKcwt9Qe+GkbQut/EtZpmIySlQe1nczUYF9z30eMXUjSEXH0ZSSv48Bza2/96hzPe1g1HZzN+v0i0UrBhfSUcvwu/qXgiZnjFqSJ3e6vrwfsIn4WVXWN74pW91V+izBztDXlpABXyMo7fPvL6dHx0WrOLFQR2IN5MAog+A69lcmLWGyQdDIOVTueSl7I99u5DYTIysr6U+ZOOum5B/VKghPvlj6ApuaLZVx12o+ue2lvrv3HlWbAIW7aK8YUVEtBr2eoXChh428pnFGy1BOHuSlXF4Tj5IAFSZXmwijdkLlctBEu62/e2tJIzgQWQAYJKlCeDs/c++BLB/MBDMOjn7FB9YQkGEkbWx/1Ms+TpTGBG4eE7zC8Pr2fcPTblmBLVrh6Z+ph2JlSycYiiRf55tfJtaA7qlSQFiIUyHYKrmWC3xZVbufe2D6gX7YL8D/xOfhTeCfmRWoYD17eLpweZeDZUQccuAeqzlsEX5UK6curGDfsimpbW+XXvrtj4SvDrpuj2FL7T2h7eXLV7wgNGWN9ZYMBq0cqEOqaJGM/R3oHACGh23etps6pUwjipmqa7dMTfIOA2j5S3MoRttSXHNW8L2S7sK02NDDT3VGM+1e103amq1V51bByXI215syijgQOze3s3xjyhUFmhXjtnh90zRsSYLEGwgI5/oJTK6eiIYs8qdg9aU4FKTVRk6veg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVFwZEZqYVpWajd0WmZXSnVkNXVhS1NvRkFZc3V5VVRzNHQzUEkzN0c0S2FQ?=
 =?utf-8?B?bnliaGNyNVpUYjNGa0tIRUlHeWtEZFl1NU1JeWtoclYvSy85MUdLYW5ya20x?=
 =?utf-8?B?a0kyczVZd1Nvd09GVHk4cHY4U0s4a3lrem1MOXpNVGhlUVVSdU5qeGRkcXVl?=
 =?utf-8?B?WlhrK1dqbVhmc1EwK25MM1ZQVWd3bExXZm96K1NyeHhkYWpyeHh3N0JSVzNC?=
 =?utf-8?B?V21rZ0MzcURxQjYxYnNmOUlCRWVsbFBac3duYkFSeW5HUHUwRms4N0tyTFFX?=
 =?utf-8?B?aFpPZm1wR0hjMlZrZ3N6RVBKT1BjS3dva005aGpHVUZyU0ZNT0loK3p4dDhL?=
 =?utf-8?B?YmlON0hRYTVpVUhXakNWTnBXc3lMY0hpVEJoYnR1NVFtR1pWcmtnWmpIWmZO?=
 =?utf-8?B?WC9zRzBsRnU3Vy9ieTRPajhlMmorR0JxUHJ2RHBieG5xdG50Q0VpT3hHRzBy?=
 =?utf-8?B?UGtLK001N2RSZzlWamtPa3B5dS9DczgvWkRqdHJKM1NKbFBuY3kvY3FselZ0?=
 =?utf-8?B?VkdQZ05GQzlIM3NmUjJjOGhYZTJIbVI4Z1BPajg0aGs1cWM0VnU4VFJWR0NY?=
 =?utf-8?B?NjhCaWhhMlA5V0ZOd0dYZDU2c2g2Q0VMa3RTa1lPbnRCUFFkQXNqZ0ZsQnpT?=
 =?utf-8?B?Y0FHOUhuaXNOYUdaRXpsNUdTTUJ0Q3J3Smhick54VmtoTVdCbDYxUEJoM21H?=
 =?utf-8?B?bzBCUUIyNHgySlVQTVVSaUlxUW53aUlxVDBPUElVUGgxS2lXb21iaSt0QVJ0?=
 =?utf-8?B?YUI1enZrRlJsUUtOMHpsWmQxSDBGYXdOTWRRNHF4Y1RZTnhvWUhnOVErMjNL?=
 =?utf-8?B?ZUVFTGhURkJaZEZQM3JTUTJ5Z2VIMERpeklPcjlodWxZWXhMZjEvTXkydDl1?=
 =?utf-8?B?TUozMmtpK0Z0SW0xcFF5MWVPV1lpUmkzWjFSOUlQY2Y1dEVWckQ0WWtnc1Mz?=
 =?utf-8?B?TVBmcGNMbXYxelZyY2R6dWVwTmtlVGNrZUl4MFpPR2hob1hSQ1hrQzhVODRQ?=
 =?utf-8?B?UWQyMGx0QjlYdHNWZlE5UURPRXpRM1JwSGF6MWMrMFptbjFoL2RPYWt5VGRM?=
 =?utf-8?B?SUhDRWJlRTdaQzZxcUFiOGU3c0VvM2YyR2JQRWZ6OHZMdUZ6WXhxMjFaQjlF?=
 =?utf-8?B?eVlPR3Y1ODBLc3NlblovTDZCcFYxczJCbmRDVjVRb2tnQUlTUnlzZmRNWE5P?=
 =?utf-8?B?WCtieEMwUG1xUGQwc1B4QWF4NmQzdzY2R2Vob0V0UmFrRVI4OGhTZ2hIdXQ4?=
 =?utf-8?B?ZW1RNXEremx4R0ROOEZMM3VnSXljU3VuSDFqUGdrbDNVN1NQWnREQjd4bUxI?=
 =?utf-8?B?TTUrUS9BekowMGpVaEYwaENhMzNhOHlpbnZzQ0hSRll4dUo4UEYxRy9Idito?=
 =?utf-8?B?eG9qMVlQZmlVU2cza3I3VTBtTlVmeDMxa3VKZ1RoeUN1OEx1c2wyU1NucWpy?=
 =?utf-8?B?OUdzK3ZKTDl0NFFOSEVYQ2xDYkhsT3lQMENWZ1JkVHdzVWZ0NFVvMHN1VXY0?=
 =?utf-8?B?L0N6Ulk0NExFQnF2aEU3SGlRNjUzUEhqckdkQlVGTURicVNjeUYzWjZDYndO?=
 =?utf-8?B?cWpuWFExNi83WDA0bHl5S0lYcmtSYXphQ0lEVytmbWJEMEcvWG9BSmJ2akly?=
 =?utf-8?B?SFBxbkcyeE5NQVFBUG1QMEhRTm85VVFRNitsYmZkTDlKOVF0dUFXTklSQXpS?=
 =?utf-8?B?dzdFQ3NjOHovY2c2UnJoVDBBQUltcnBXZERSTWhKZ3gyMDRyeDFTMCtIUTY3?=
 =?utf-8?B?VjVkckhiUStJRlZ6aFpPTW5xU1NSZlV4N1o4YzVBeEF1RzZobkkyVFVKMVBx?=
 =?utf-8?B?TytMR0l6b1hHeU9lVVRjZFk1SzJJTDUxalBlV2YyUDRRQi82Q2xTR3RMRThT?=
 =?utf-8?B?QVZjMTlvaDN3b2J1VmlFN010RjdSb1ZvVXQ0cjVJM2V2aVJJY3kwU0VwZlMy?=
 =?utf-8?B?MU0xV24rWWFiTHN6bVlpZEJZVGZ2Q2xzZmtPTkkzSkhIR1NaejJHdUJ5THpF?=
 =?utf-8?B?NXRTQXBSR3BxeXpnRitWNjlGc3RZeDZkdGptSG9vMlNCKzJ2Q2hFY2R0TXAy?=
 =?utf-8?B?MGpEdHFrUVB6MHhxWng5TnNRY1p4WlBlYnQ0aDFhQnh1YUh3NzlrZWxnVVlw?=
 =?utf-8?B?cHNPUnRoTTc0dE16d1ZKRFFNT0plVEt5TVlFKzRIcVpoWDhsZ2U5OXJIb056?=
 =?utf-8?B?S0dxaXJ2a1J6cXh4bFRGZmpDdjZENGtMakMrY1RGWnlKVHRxcGxxVnZ4aWNz?=
 =?utf-8?B?aWF4dXU0SjZiQ2JRK0lzaWx3cERvK3VxUVRZOHhEeUdFWGRsL1JGS1lSRXVI?=
 =?utf-8?Q?pZpe7FvtbG/EuX6ciO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41db1976-fdb7-40bd-9f40-08de88dd9d98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 13:10:55.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATGzJF1T9XSdOb5i1cNz/O1mpugQfxU3YjBxJSx1F1X4QAL2o8JIaoOiUO8/7/+WsPXEbgNAb+/WwO1jwhGloA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121

On 3/20/26 11:08, Aithal, Srikanth wrote:
> Hello,
> 
> I am hitting a failure when shutting down a SEV-ES guest (smp>1) on
> recent linux-next, and narrowed it down with bisection on the host
> kernel. The issue appears with more than one vCPU (e.g. -smp 2); with -
> smp 1 shutdown completes normally in my tests. The same guest shutdown
> path works with an older host kernel (<next-20260304) and is also
> avoided with current QEMU master or by cherry-picking a specific QEMU
> commit onto v10.2.2.
> 
> Environment:
> Host kernel: linux-next, tag next-20260319 [1] (also observed starting
> from next-20260304).
> Guest: SEV-ES Linux guest; -smp 2 (or more) reproduces the issue; -smp 1
> does not in my testing.
> Hypervisor / QEMU: Initially QEMU v10.2.2 (stable). Later tested QEMU
> master at 8e711856d763 [2].
> 
> Details on issue:
> 
> After SEV-ES guest shutdown , the serial log shows a register dump
> (example below) .
> 
> [   12.613383] reboot: Power down^M
> EAX=00000000 EBX=00000000 ECX=00000000 EDX=00a00f11
> ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
> EIP=0000b004 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
> ES =0000 00000000 0000ffff 00009300
> CS =f000 00800000 0000ffff 00009b00
> SS =0000 00000000 0000ffff 00009300
> DS =0000 00000000 0000ffff 00009300
> FS =0000 00000000 0000ffff 00009300
> GS =0000 00000000 0000ffff 00009300
> LDT=0000 00000000 0000ffff 00008200
> TR =0000 00000000 0000ffff 00008b00
> GDT=     00000000 0000ffff
> IDT=     00000000 0000ffff
> CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
> DR3=0000000000000000
> DR6=00000000ffff0ff0 DR7=0000000000000400
> EFER=0000000000000000
> Code=b0 96 b5 61 ca ef 3f 51 00 c3 65 51 19 77 b1 e0 e5 e2 91 b8 <0c> 5d
> c7 fc 59 bc 2b 6f 90 89 44 23 ec ec 2f 62 fd e0 8f d5 c7 31 24 70 e2 7d
> c6 ee 00 00
> -> Hangs here
> 
> Host kernel bisect (with QEMU v10.2.2) led to:
> 
> Good (no crash on guest shutdown):
> 32d76cdfa1222c88262da5b12e0b2bba444c96fa
> KVM: SVM: Move core EFER.SVME enablement to kernel (local build tagged
> 7.0.0-rc232d76cdfa1222 during testing.)
> 
> Bad (crash reproduced):
> 428afac5a8ea9c55bb8408e02dc92b8f85bf5f30
> KVM: x86: Move bulk of emergency virtualization logic to virt subsystem

Any chance you have the enable_virt_at_load module option set to false?

> 
> So the first bad commit in my host kernel bisect was 428afac5a8ea. The
> commit prior [32d76cdfa122] did not have this issue.
> 
> Later I used QEMU master and with same linux-next next-20260319 as host,
> it did not reproduce the shutdown issue .. that was using QEMU master [2].
> 
> QEMU master contains 56d89db2cfd82c53439778fbf39294bf35194dba (target/
> i386: convert SEV-ES termination requests to guest panic events).
> Cherry-picking that commit onto QEMU v10.2.2 resolved or at least
> avoided the shutdown crash in my setup.

Well, if it is converting a guest termination request, that is still not
good. It should be a clean shutdown.

> 
> 
> Questions:
> 
> KVM: Is the interaction/issue with older QEMU (e.g. v10.2.2) expected
> here, or is there anything that should be adjusted or documented
> following 428afac5a8ea, like for multi-vCPU SEV-ES guests?
> QEMU: Would a stable backport of 56d89db2cfd8 to 10.2.x (or equivalent
> handling of SEV-ES termination) be appropriate for users staying on
> stable QEMU while moving to newer host kernels?

That wouldn't actually solve the issue, it is just a much more user
friendly error message. Is there a termination event in the host dmesg log?

Thanks,
Tom

> 
> Thank you,
> 
> Srikanth Aithal <sraithal@amd.com>
> 
> References
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> — next-20260319
> [2] https://gitlab.com/qemu-project/qemu — master 8e711856d763
> 
> 

