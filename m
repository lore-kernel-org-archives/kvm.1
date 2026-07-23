Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9303D1AA4;
	Thu, 23 Jul 2026 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840868; cv=fail; b=qwOi6WhkojcWVGwbgJJT3QjLfyTJUTfA1h8QcIgYSGwPRLkVOjgIPnJmjnVsnT9uloKulW1zq8pudnRJZKJuohXZiM6qrHI0BI6Vm16Nm9y6WNEYpiZASrKU/ZI22ZzvLueD237U6TBAuYjcR8M/7LdllWCki74DdmFD3/HNilM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840868; c=relaxed/simple;
	bh=nJ9OY+4J4FS0gR3WAX3JyyInz5xt1dDe5NS5X2czL8g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ72ogR54Ll7kxvdLMbI2Lus1Xn1L8ThUjxqwbToPaxupPVN6T+0WpUYE/OOmA5pqfvczDX1pAbV952M3Wve3IuxoA6Y9K9ysW/IJ/gBAfl0BKT0HdkOeN677tZg1yRoBJSGQhM5WQzJT3WBkq/R0E4fPUvT/h7ZCrNrtLrs6tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=riD/BMa/; arc=fail smtp.client-ip=52.101.52.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="riD/BMa/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SH9zJokoH2AURm/0sVEs6ni56Kkb2ugIJQVm5tF2kzhlyu1WCxMR8Nq+eX3Etyg6X5YMEUCoRZaVouSuX3OU9SFudA0w4Wq9IumvraqsJ+korEFXXMhrabZPyUSyHE63F0pWkaOWsU0b/H5PUzrrVk+PjCbljAhZ0xb9/q9pi6QLNh+UZS08eYa4cGRevy6nvJqwvZ4cxXNP941aSJXnDXALvogeZkQxOi9mTwo2v0OWRoH7JSYF9JBgIbMV7bl6KGuXI6vFSteJAjmfGc6I5eXbAQabSazn80GxffaE1yDPOo5v6gUqlbAzC9WrAyNgq7O5Ffv27FnBGSe3l31nCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhXL20kr/s0SALLI5IOejOx5d854D5Tvv1eCqhSvXNg=;
 b=w9/l2dqdzxkdjF9PF553HFgq+XbXvhvU8lO+ClmSGmJLqdFKxPKao9IKjiB1r7z4yxo05LPLI1j66CGFFg08zjOkHCRKZI0xOraeK+ZUyrbOfmjsv7iamieANwccmcqpGlKcX/vAhw6+MIdo0b1rW10rz/lECp7u9PyYcQEhPSTh5tgs1f/KzvEXYjRQ79c2tqafrenMab+bKYvhGXTbcDMvrmLrhDN+TfMd/FyPzIfUjamEQIlirYGsptxJ4n7ZOjvOhW1UKYLvEG6DX0xMTwRP3ScRO2DBirKEAz3i+V4jHtR91Qo6tpMMm9J4PW8EACUpWwz3gLD//6F2wZtQCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhXL20kr/s0SALLI5IOejOx5d854D5Tvv1eCqhSvXNg=;
 b=riD/BMa/GFjsKz8CrAPIVlWQwRu081DIFeVlePIZUqRNkY6SYK8a4rEyRRYp5QSnWpALgmiGAWELFMvDlN1k6CnS1q+b5mWf07CD693SzgWv/dluNcO279nnHtwrY0Wa5wOPXT776Hrbpoweenv/n8lc9zPw9bsEuiOoFS37Cuw=
Received: from BL1PR13CA0319.namprd13.prod.outlook.com (2603:10b6:208:2c1::24)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 21:07:36 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::a3) by BL1PR13CA0319.outlook.office365.com
 (2603:10b6:208:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 21:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 21:07:36 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 16:07:34 -0500
Date: Thu, 23 Jul 2026 16:07:17 -0500
From: Michael Roth <michael.roth@amd.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: Sean Christopherson <seanjc@google.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV
 {en,de}crypt debug ioctls
Message-ID: <7rg4rrbyecgoy32qzrye2r2wdy7bbalgl73anx6gd3qfndc2ar@7auj6hyujjg3>
References: <ajNQ_Ix5e0p6FuFT@google.com>
 <tx3hcnrhfbcz2p7e7umc5o2zrw74pluzuzgtlqt4dz5cc5nhxx@6tzzorc25nqw>
 <s7jfbw3tnfgmp6blfqlfoi7yhq6f5n6xl62zzty5up45cqtsty@ljpjlvqw2gyy>
 <ajrkryMxHZtsMvga@google.com>
 <6xyh7xa53k2s7bytlkcys4pyq4756rwoly5q7swrifv3td6dey@3h5e2e67lkvj>
 <ajsjQtpZb-h2BdPh@google.com>
 <ajxLCMgLQe-JiRfq@google.com>
 <45ixyum4upln4b2yvasovm2bmsfxyfezsi23vsr75r4fklelef@utxv4mymvfcd>
 <ajx1Y93iX2oV-DLa@google.com>
 <2b4d5faf-1568-4080-92b3-1e525a11b194@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b4d5faf-1568-4080-92b3-1e525a11b194@redhat.com>
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ecb3e3-8286-486e-20d2-08dee8fe6bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|22082099003|4143699003|11063799006|3023799007|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	hBLI6I+kYBC884JutN0yfwt9KDrXgQXpbStE9xRh4wHEPpIj9T+ECbpjFH9E+vnJhts4qc8PPLkgmk0zTIBg1Tq4pO2juL488yxdAB+IUsWa6XhQBR3frPaCf3THetIduOI0vawFH69N5k8iNOHqZCWTQIJ1fWed8lkTMPFkFbKS0YuPhRFMY+5ZILx+2aQUq01VBb41tbn/GPxByBiKWMCSVqpkvH/HE/uhRqB66D/3TK47B5gnh3cYLNVNGawR3B20rVRtYM+5obKYP3ynntf0fmuOAywvWZTDr5Cv/7WjhEiaVzCzUlNFu9m5U1oLUEiZyx3QjJq5RsFSWCvF17o4vG+5YgpLN3noZafpg3q15f1oQO3el8wP6BMmAuCrGL0ceArv7yUFjRAbPVEr5VXYdUsuv31Pilz3ey9jx3UD060qJwQJ4HxoB9cMeXMd4afIMzHWdlnxlCM3cDqX0HtAUq+WI9QsUiWVRr/F5U4o0kTix+khTmopxS8mA7k4nnsiQ6kvYHVfGqoLLF1q2zsxgHEboVoyfPbmXR+8U79bhd/LNrMf/eaAR4wtyjPKWdMDX861aRcWqIvfV4cYt8RFqAyHXGG/7L50TnCz5vX8vCray8AKzliJIcCYtIXre124AKWVw7niHRY//Hc8YlgKi/+P3qBbxgCAfgVBbtqBPW8vRAtWu7/QlBM07SFwJ6mACUMD7wpBRji5NWQlWA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(3023799007)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KFgl7O6qgT+dmDwBboTIiV0IYVRyjrwHW0rujWcz9vZS/oz8eJKmIPOUrCr5Z3Cciu4w+aZLl7tNseahRLsSlOFuBJE49mSk5LgdB6bxfHww8/FYG35Ekkp7vKiEc9GfZMS3XreoTMYfzfY6CXGEBNidk6ht7qMuv3c1WAX7y3ESLd+2E9Xvk6mTUlHrCe6SnAlrUIqa5lPVsyY7Qp2OJrSt1pEdD/X8EWCK3Id0SkqObHaLaRlJZxvkwoPde/lvzFzhqTOmaU8nAB2RsRZvcUWI8wFWtzDbSO7s2p2Jyazqz1zWEBIpExkJj68yQAc/rGU3MNEMbCBowehhQIq6uPI5EONgzjN8SaDbENgAlHPoEddDObQqOz+tm5YPwWnGYOfEX5ZIUsKCK43rW53URVXvVuGDCPyCXmx6VkINniDsm9tZQEd1GTHGCT9VAf2S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 21:07:36.2861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ecb3e3-8286-486e-20d2-08dee8fe6bee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

On Thu, Jul 23, 2026 at 05:17:26PM +0200, Paolo Bonzini wrote:
> On 6/25/26 02:25, Sean Christopherson wrote:
> > On Wed, Jun 24, 2026, Michael Roth wrote:
> > > So maybe the bounce buffer approach would work for DBG_DECRYPT at
> > > least,
> > 
> > Yeah, DECRYPT worked fine, it's all the others that break.
> > 
> > > > pread() doesn't work, because the source or destination needs to be a userspace
> > > > address, and so any RMP #PFs will get eaten.  But copy_file_range() makes the
> > > > world go kablooie.
> > 
> > And the risk isn't limited to copy_file_range(), that just happens to be the first
> > syscall I found that did what I want.  E.g. any memory that is kernel allocated
> > and mapped into userspace would be problematic, because that memory could be fed
> > back into KVM.
> > 
> > So I don't think we can fix this by playing games in KVM.  Which is pretty much
> > why we ended up with guest_memfd: the only way to lock down memory to the point
> > where we're 100% certain it's safe to "poison" the pages is if KVM sequesters
> > them away in a dedicated file system.
> 
> Yes, I agree that it's basically the same issue that led to using
> guest_memfd for SNP.  Another one would be io_submit().
> 
> > > > I'm fairly certain the issue is that the encryption is salted with the physical
> > > > address, and so encrypting at X instead of Y will yield different ciphertext.
> > > > I.e. any command that encrypts the contents in the destination (or in theory,
> > > > decrypts, though AFAICT none of the commands do so) *can't* be bounce buffered.
> 
> Yep. :/
> 
> > > > I don't see a way to salvage SEV/SEV-ES on SNP systems, short of requiring
> > > > CAP_SYS_BOOT or some other elevated permission to do *anything*.  Or redo SEV/SEV-ES
> > > > support to require guest_memfd for operations that require putting pages into
> > > > Firmware state.
> > > 
> > > Yah, short of maybe the above approach, I don't see any way around it atm :(
> > > If you think it's worth pursuing though I can give that a shot on my
> > > end.
> 
> The unavoidable ones include, if I understand correctly, not just
> DBG_ENCRYPT but also LAUNCH_UPDATE_DATA?

That was my understanding, e.g. a user could try to use the HVA to
trigger the copy_file_range() path right after
snp_map_cmd_buf_desc()->rmp_mark_pages_firmware() is performed as
part of servicing the KVM_SEV_LAUNCH_UPDATE_DATA request, and it seems
like that would trigger the same issue. And bounce buffers wouldn't work
for that one either.

and it's kinda important =/

> 
> For encrypt the destination is the guest memory, so how would adding
> guest_memfd support for SEV/SEV-ES work?  The guest doesn't have a
> page-state-change call and neither does it have RMP nested page faults, so
> how would you communicate the private<->shared switch to userspace?

During early SNP hypervisor development (when guest_memfd was called
"restricted_mem"), the patches were actually based on top of some patches
from Nikunj that added guest_memfd/restricted_mem support for SEV-ES.
One nice thing about that is it brought about support for lazy page
allocation instead of relying on KVM_MEMORY_ENCRYPT_REG_REGION.

The support piggybacks off the KVM_HC_MAP_GPA RANGE hypercall that was
added on the guest side to enable SEV live migration so the VMM could
distinguish between shared/private (and punt private page handling to
something else). By coincedence, that's also what SNP/TDX ended up using
to forward conversion requests to userspace.

However, since SEV live migration never became a thing upstream there's
potential that the KVM_HC_MAP_GPA_RANGE handling might miss some of the
newer cases, which would lead to silent corruption (though with SNP
enabled we might still get an indicator of whether or not the guest had
the C-bit set, so we could detect a mismatch that way and maybe even
be able to handle implicit conversion requests).

The big issue with this approach though is hugepages: we'd be dropping
existing SEV support for both hugetlb/THP unless we implemented in-place
conversion support for SEV-ES so it could eventually benefit from the
hugetlb patches at least, but if in the meantime it's 4K-only I'm not
sure anyone is going to get much use out of that, or still care about
this support when gmem+hugepages is eventually enabled.

> 
> > I say we wait for Paolo to get back from holiday (in a few weeks) before doing
> > anything drastic.  I'll send a patch to fix the existing selftest though, no
> > reason to leave that hole open.
> 
> Well, everything is drastic.  "Fortunately" AMD helped us with the firmware
> update that already hides SEV-ES on SNP machines (CVE-2025-48514), so at
> least there's a precedent.
> 
> Could we say CAP_SYS_BOOT is only be required to create the VM, after which
> it's up to userspace to not screw up?  Probably not, because userspace can
> then drop privileges and operate on the file descriptor; which is the actual
> dangerous part.
> 
> The only not-horrible alternative would be a default-disabled module
> parameter that allows SEV/SEV-ES on SNP systems but adds TAINT_USER when you
> create one.  And downstreams that don't like the idea can just rip out the
> taint.

It might not be as elegant, but either of these seems more useful as a means
to allow users to continue to be able to run existing workloads if they
trust their userspace/VMMs. I'm worried the guest_memfd support would end up
being mostly-wasted effort at this point since it's not a
straightforward/drop-in replacement.

-Mike

> 
> Paolo
> 
