Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8F3CF056;
	Fri, 20 Mar 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022925; cv=fail; b=qOUHlHb0eaI6SzjAgbyr3gJlcE8U8FTA3WaLBfCFh6m7Kw4prcHbvF4xtBUDtVTTYyIKmUxGhl8GydULjUuvVGQFuAq7GQWM8p5tDBS2W2Icxx9Z+MWQ8a5iRWWVKbCZzikjCA0UgcBvlWYQWXYvzBm155TfB6/bP5LkBr8bpW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022925; c=relaxed/simple;
	bh=pFeT+2ygGK17m6mgvaHyrVyQL6BxlOFA6ohqljaS/88=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=ErzzSunLhHtmPU5fmK8EdK9j87reJO3a3Qma7TBYiG/hcFIxcLPnfUbhhWP+76l4CErblRcDh+Wk+Cl66r0ZEZ4KfucQ7FXr9ElMqKI5lwOEI6uT2SpPOvjXxwi7etleL7IJpSUYNLIsePWnTfePcJXXYXv5gtqZBdmv1AgZTbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=USfc+r3c; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="USfc+r3c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEWq3ujo70y5YWCYsqq6zmN+QInmh20FTZBDYxRH0mQNYOPPObLNdXxYRru1vbAK/m+vzWyzb2CfmiSWJ4KTtC8ZiJLOPImfGEWFdKttrriZ/0SbFM1xw5aDvSa9Xcl14i8fJWJnGIwvZxql16M/pgbggPmu70Xc3jDlsUO5Mkrfsy1Y8TH3d9O3crAbkdgAkwmJPnL7/KkgOesjQ3O9O/6PX7/+L3O0QVW+3BZBXxS48It4yUOW29qYK3OOkW4O/PNQ0CjIQL52DbN54Y0VHBZaOmFl1EuL7NVen9sWSfdP5lak6AdJl41cD/6OerNfs0IAlcRs/03tDOY9meY3tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyD/3geiRGZgqqJpxp238iTxa9q0qcnkgK+k779djbc=;
 b=dei35CgyYdjKAZxw0bp4UsjvGhCMOxzPgvAkKJ+BEqEcKY0ZJRpOcGmSLL3tQjuhSOlkUJMhnG0Tu6TXeXuk1MmHGp6SQdlVPIGhfY6spSulN3ZQnuk/G6q4yob7g7Pu01IFYtacbhXGEULQHMpJ3UceeHB0XDnUOWiZ9Sb7mZ6Nqh0mpI8oitshQEfrQs8L7GpzjeDSVr5ZofJr67m3pxZH73OU28RaKh2i45iZlcFssztFUwBHGGBSBD3347N5kNVaPAd8ZtQIsTsizAvnl0sJ1pu6YFJltTNMP1b5D9vUFDN1DoCVIoYbdbMl50qwG6pbdtcmpMysuKey7XJ56Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyD/3geiRGZgqqJpxp238iTxa9q0qcnkgK+k779djbc=;
 b=USfc+r3czx+ZixVS82Amv3LELwsU9GmhlUwA4qTNUnqblTbR46UusiA14Kt8fZev7dJ3CONuyQbJak/12v4DB5HW4sSGxhaHQnWGfMphiRJl1XQUVkiUCGvfCJoW030GPrRr1DF6T61VEurSzbldX0GQXSkBv306whMr5SCR8qk=
Received: from BN9P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::22)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 16:08:35 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::46) by BN9P221CA0025.outlook.office365.com
 (2603:10b6:408:10a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Fri,
 20 Mar 2026 16:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 16:08:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 11:08:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:08:35 -0700
Received: from [10.252.193.70] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 20 Mar 2026 11:08:33 -0500
Message-ID: <c820e242-9f3a-4210-b414-19d11b022404@amd.com>
Date: Fri, 20 Mar 2026 21:38:28 +0530
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: open list <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>
Subject: SEV-ES guest shutdown: linux-next regression with QEMU 10.2.2; smp>1
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f92dfdf-b108-49a1-94dc-08de869af0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EvAwBmdvgdhSrX/CiGFjGC1AkaIYzLY9Ny0tvszoJtSKk9+8aSnZkaadLCOxjOtdxHAOmHblcmUxmgjH9WyZnqgAFwppDYJbY5WsTY36UVOX2UQPmJ93fgu+Zxy1qCANKhZ64/iJP6WP7YkJfYYcsXtrdDAIHkERXzvfp6xaqy5Hfm6YLLJar+GLqaMXNlY4ERRW5vrhPJkq7PTyzOptD5kFjSsuvjgY887E0j99tvZ6OGTYw7RhCzJepmOmJ/Wxhlfv3+HJTE581JfO3n2QUXh4C3Tc+ixerbZZRt4ug3e2Oo5Jg4SN8A7ShNxc8JUg/U6CqnZl8kwLDivfytOCwu3jk+zO+TKpc46LZwafOks4osvoxN1dk7triwfqVVwfU2xEh9SmkMVMVtf3r7UhaY/mz96/YhYq/ooZVLmgWlU3ubRWIr79L4NGa1mmc3k7NpC0aNfdzit+O89Vp1x0CJ3glIRnLYzDnJxL4T5a81kInvHzU+saKVtnOlFQyenlMfKD+mIk8M1twjzL+9k4QV7ss470Yp+MLRdaKIzdQvVOM48kxTC5WSiZi/3AsaNiJftJ9T3tRBT3nZivjq1U7CtXj+M2iafPTIjpMOCGwbbbbf/qhJYJw0gA+Hy64kuvpXDwdIgXCAq/uDb/k2g/PO08/LJFvOiLFcIadNi4LzfBdbBK7SUkRgWwYNMLGPsVDI99tnRzOXpgz12Bt2IkLHpUWHoG30FUuuHAr4wEhU1aIrGjqjsK9N1MAwGmcWKb3vbThyTmhZty2d4f00AXnH+EfDpPJWN1XjmyVOTW8no=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CiMOaaayADgjaGm+kS5BZx6Nmg0E1w0Jk9oBqQ58srEoQbjWnB6eCmsu8k15akI9E6/rBa9dx22z/08Jc0YgV+A+UKB2vRgRBmZwyzNV0PGhYK5LHTIpQhOfHs3LdTU1E08X/3ye1k56L+F7i4oWX59Lg3gZDNOAdx9y6HBVKW7TxatMWJVkc6Ue1X+9GK15CeDvGwXHmVjbQGPTDbZ9Opj5KhrufFDPoa+xQ/fFQo8AvZ80XMxFHDTKhDDTi0XHw+OmI2Gs4k+f0OHFPnQEFIU3mrPzzB1W1D62wsBmr5iAQU1UZN6V1PnjTs7QEzmg6UkfN10OuQQJLCrI935owVnkpHAHZh3PbYVs4aA0Jtksm24nf81p9DHFrZaUAX1wWon8kP/WZLAkAz+zhkKTB+OSPZPc5NsDrpKr5Xgy1jQfgFv9W3gWiAw+YZjWbkpc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:08:35.5643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f92dfdf-b108-49a1-94dc-08de869af0ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744

Hello,

I am hitting a failure when shutting down a SEV-ES guest (smp>1) on 
recent linux-next, and narrowed it down with bisection on the host 
kernel. The issue appears with more than one vCPU (e.g. -smp 2); with 
-smp 1 shutdown completes normally in my tests. The same guest shutdown 
path works with an older host kernel (<next-20260304) and is also 
avoided with current QEMU master or by cherry-picking a specific QEMU 
commit onto v10.2.2.

Environment:
Host kernel: linux-next, tag next-20260319 [1] (also observed starting 
from next-20260304).
Guest: SEV-ES Linux guest; -smp 2 (or more) reproduces the issue; -smp 1 
does not in my testing.
Hypervisor / QEMU: Initially QEMU v10.2.2 (stable). Later tested QEMU 
master at 8e711856d763 [2].

Details on issue:

After SEV-ES guest shutdown , the serial log shows a register dump 
(example below) .

[   12.613383] reboot: Power down^M
EAX=00000000 EBX=00000000 ECX=00000000 EDX=00a00f11
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
EIP=0000b004 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=1
ES =0000 00000000 0000ffff 00009300
CS =f000 00800000 0000ffff 00009b00
SS =0000 00000000 0000ffff 00009300
DS =0000 00000000 0000ffff 00009300
FS =0000 00000000 0000ffff 00009300
GS =0000 00000000 0000ffff 00009300
LDT=0000 00000000 0000ffff 00008200
TR =0000 00000000 0000ffff 00008b00
GDT=     00000000 0000ffff
IDT=     00000000 0000ffff
CR0=60000010 CR2=00000000 CR3=00000000 CR4=00000000
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 
DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000000
Code=b0 96 b5 61 ca ef 3f 51 00 c3 65 51 19 77 b1 e0 e5 e2 91 b8 <0c> 5d 
c7 fc 59 bc 2b 6f 90 89 44 23 ec ec 2f 62 fd e0 8f d5 c7 31 24 70 e2 7d 
c6 ee 00 00
-> Hangs here

Host kernel bisect (with QEMU v10.2.2) led to:

Good (no crash on guest shutdown):
32d76cdfa1222c88262da5b12e0b2bba444c96fa
KVM: SVM: Move core EFER.SVME enablement to kernel (local build tagged 
7.0.0-rc232d76cdfa1222 during testing.)

Bad (crash reproduced):
428afac5a8ea9c55bb8408e02dc92b8f85bf5f30
KVM: x86: Move bulk of emergency virtualization logic to virt subsystem

So the first bad commit in my host kernel bisect was 428afac5a8ea. The 
commit prior [32d76cdfa122] did not have this issue.

Later I used QEMU master and with same linux-next next-20260319 as host, 
it did not reproduce the shutdown issue .. that was using QEMU master [2].

QEMU master contains 56d89db2cfd82c53439778fbf39294bf35194dba 
(target/i386: convert SEV-ES termination requests to guest panic events).
Cherry-picking that commit onto QEMU v10.2.2 resolved or at least 
avoided the shutdown crash in my setup.


Questions:

KVM: Is the interaction/issue with older QEMU (e.g. v10.2.2) expected 
here, or is there anything that should be adjusted or documented 
following 428afac5a8ea, like for multi-vCPU SEV-ES guests?
QEMU: Would a stable backport of 56d89db2cfd8 to 10.2.x (or equivalent 
handling of SEV-ES termination) be appropriate for users staying on 
stable QEMU while moving to newer host kernels?

Thank you,

Srikanth Aithal <sraithal@amd.com>

References

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
— next-20260319
[2] https://gitlab.com/qemu-project/qemu — master 8e711856d763

