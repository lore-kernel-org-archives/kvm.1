Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42F2F745D;
	Sat, 17 Oct 2026 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792197236; cv=none; b=PzRfufpJCgeCuyrK6d9XibMWmMBXnTz37HevLxlVlURqxf0FyXMmwxOFaIq0dXUFarufff2N5WT5OL0pQ6I5robwrBu8PCGQo3txfGO8GVan+Plt4SUsJ80otS73FDsJmqgo5Eco4CVVHHmGJE9kNq6zVqbuVyWNzSY8TgysMSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792197236; c=relaxed/simple;
	bh=P1H4HIRk4TLCDrXsvN32UvogvT28OQer94t48GXMmm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ieXqwQf3ieKCRSrFWbiy6+5xvY+MBaB5YZeOnwqEO16NFRfokDoO66s1qo9uccs7wx3y96N3oy8H6qvtyPYkXXrlCt0sjDbT0UMHbBEWJa/tJFFC9V2DHJpx1lqv/yKR7XVuDCAOyan352XqjrjpVKLWT3VlUwkpgG4tWWisDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=Jn28FIVF; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="Jn28FIVF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xw2HkNwYUkjzXQ86fXAOwvhJMWzdtTmLE9aW73cNeT4=; b=Jn28FIVFWKg5YSW16c0seIlzFc
	+JRTbAU+SfwzbypkbfMScNz9r+ce9aXJ5KqMDpYPE5qYmkYWMa064+a2GGvJCgYMBXBw9ug3mzeL/
	asupVMxZYLZIwmPss0/5CBmmPQakCeu45Kp+3qazSfCvHy2+oRYoGlrgTAZ1sIWcX6KkuooSseOq3
	fjulK5zW4kZQBPQhUjyARtN8wgmYDx06LSsoOuyNTOIsEhwfftU7F5tZprvXCAghH/36TZ9oyFwnf
	LglJdqj4LIFyYSOBeqQCgPsI7TecaSpgS+MZcB54BIXsm7oK7923yId07RGn1HiAcS9cP3KHfLpj9
	OTBZhcrQ==;
Received: from mailer.gwdg.de ([134.76.10.26]:51522)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xHrjM-00B5eX-0c;
	Sat, 17 Oct 2026 01:52:55 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xHrjK-000D3R-2b;
	Sat, 17 Oct 2026 01:52:54 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 17 Oct
 2026 01:52:53 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [BUG/RFC] KVM: nVMX: nested_get_vmcs12_pages() kills the VM when the APIC-access page is unbacked, unlike its sibling pointers
Date: Sat, 17 Oct 2026 01:52:20 +0200
Message-ID: <20261016235221.33726-4-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mbx19-sub-01.um.gwdg.de (10.108.142.54) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Hi,

nested_get_vmcs12_pages() (arch/x86/kvm/vmx/nested.c:3448) maps three
L1-supplied guest-physical pointers into vmcs02 on nested VM-entry. Each is
VALIDATE-checked for format only (page_address_valid / legal-aligned-gpa),
never for backing, so a legal-format GPA with no memslot passes every
consistency check and can only fail at the kvm_vcpu_map() step. When that map
fails, the three pointers are handled three incompatible ways:

  apic_access_addr        -> vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR,
                             suberror EMULATION, return false. The VM dies
                             (every userspace VMM treats INTERNAL_ERROR as fatal).
  virtual_apic_page_addr  -> clears CPU_BASED_TPR_SHADOW, or writes INVALID_GPA
                             to force a clean VM-entry failure -> L1 gets a
                             well-formed VMfail.
  posted_intr_desc_addr   -> pi_desc = NULL; clears PIN_BASED_POSTED_INTR and
                             runs L2 anyway, with no signal to L1.

Same function, same fault cause, three outcomes: kill the VM / clean VMfail /
silent feature-drop. For an architecturally legal vmcs12 (L1 is free to name an
unbacked but well-formed GPA), the apic_access arm turns a guest-controlled
condition into a fatal KVM_EXIT_INTERNAL_ERROR, which reads as a robustness bug
next to the sibling behaviours: a nested-entry input problem caused by L1 should
surface to L1 as a VM-entry failure, not tear down the VM.

This is a fidelity/robustness inconsistency (E2), not a privilege-boundary or
memory-safety issue: no host crash, no host-side WARN, no cross-VM effect. The
scarier sibling -- deleting a memslot that a live nested map has pinned -- was
probed separately and is a verified negative on the default
allow_unsafe_mappings=0 (the pin holds, no splat).

Currency: c1214f293d77 ("KVM: x86: Fill kvm_run exit fields in common
get_nested_state_pages() error paths", Cc: stable) relocated the
KVM_EXIT_INTERNAL_ERROR fill out of the per-site arm into the common caller, and
10180a277549 ("KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages
fails", Cc: stable) hardened the stale-PFN seam -- but neither changes the
map-failure *policy* divergence, which is what this report is about. The
apic_access arm still returns false -> KVM_EXIT_INTERNAL_ERROR.

Question / suggested direction: should the apic_access arm be made to fail the
nested entry cleanly (as virtual_apic does), rather than kill the VM? The same
three-way divergence exists on AMD inside nested_svm_merge_msrpm /
nested_get_vmcs12_pages equivalents, worth aligning in one pass. Happy to send a
patch once the intended policy is confirmed.

A reproducer aims exactly one pointer at a legal-but-unbacked GPA
(0x1_0000_0000, page/64-aligned, <= MAXPHYADDR, no memslot) with an
otherwise valid-by-construction vmcs12 and a backed-GPA control arm per field,
reading the native outcome plus the run anomaly from the kernel; deterministic
across runs on Intel 7.2-rc3.

Thanks,
Amirmohammad

