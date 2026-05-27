Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB383AA507;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896003; cv=none; b=YDq6B4apaQlNqMLDsEDzGaSziCI56m+ysAAJFX4Zy3k4YZs6mHIfnZ4pVE3lvxeLGL+fUjZleMulZJ4WmA3z7olASIiJT3WSkWU+zvjza5jaU0OVNGJDzkgiaqHgQvbRZTzENmj4+za52aX8ymG52WKYLSLHtgfI+Nt5EAtc0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896003; c=relaxed/simple;
	bh=h5ivLqPOtFuMratoUltIBcXA9xXpaycNqIAiiVaY+vo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r+zPTJNU2TxWCvpew7NzKdciwNw2jJAZdKF7yZi5x7oQ8PUYdAh8TM/sAGFC+RBiLRivdxax7pK7ROkN98+4o1XqSv4q30vsBe14cIMJH/mnq9hdmCUTssgRKHNDtbekMmFs30A3nqt2L2rR/ZJguNqI5usyy/K90MkWMDLg5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgLNDbfe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgLNDbfe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B73FC2BCB3;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779896002;
	bh=h5ivLqPOtFuMratoUltIBcXA9xXpaycNqIAiiVaY+vo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZgLNDbfeTtC3ppE1ycZWRO9pJA5WebnhAdqmoK21eu7PlcvMRgpmiHHs7L6DtZto3
	 87cUPGERLHDrWOKMlYtwU/klOA9+tCQoxC4JwENEUfcpJi8gryR5rzQ6BBsYRLefcl
	 sgLWix2ITTXkEzVHAm0JttekojS/UkF1n0cGaml0uFqEI078xjlEXqeRbtESUJFmTN
	 ggKooBfCypscdoAUWhz+laQ16vzPuQf6mEqIJlq3Ci0AR/GffqCpvQMzbl0jHrdANy
	 VdlxgAp5AWmChzuQK5LNsCPyiHDFkELLJatMs3wVRaMJeon78fJdGZNa7ICv5Tmtwu
	 ZZ7/d7rksxo7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52311CD5BD0;
	Wed, 27 May 2026 15:33:22 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Subject: [PATCH RFC 00/12] Document synchronization used in managing guest
 faults
Date: Wed, 27 May 2026 08:33:12 -0700
Message-Id: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALkOF2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNz3eyyXN2c/OTszLx03ZT85GJd42SzlNRUg7TEpORUJaC2gqLUtMw
 KsJHRSkFuzkqxtbUArG/ejGcAAAA=
X-Change-ID: 20260527-kvm-locking-docs-3c6dee0fabce
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
 vannapurve@google.com, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779896001; l=2048;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=h5ivLqPOtFuMratoUltIBcXA9xXpaycNqIAiiVaY+vo=;
 b=c86I+Wkb6+CiaF3raHTi1YGp98pn1fMqF+h1ivq65CpJt+lVxisSb8FEQ5tUneg/sXQujPwO+
 ps5IWtwTiXsA1T2xO/Oo8r96KccnU7sFJLwYuW4RaAAKsrkilwumm6N
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

In [1], Sean suggested consolidating comments for some functions.

While trying to consolidate comments, I read up more about synchronization
used in managing guest faults and put together some updates for
Documentation/virt/kvm/locking.rst, including some fixes to the current
content.

I'm generalizing the kinds of functions Sean was referring to as
"documentation for functions that depend on derived information from GFNs",
and kvm_gmem_get_memory_attributes() from the conversion series [1] will
also point to the documentation that is updated in this patch series.

[1] https://lore.kernel.org/all/ag8JIlHjohAOC3-g@google.com/

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
Ackerley Tng (12):
      Documentation: KVM: Elaborate comment on kvm_usage_lock
      Documentation: KVM: Consolidate notes about cpu_read_lock() and kvm_lock
      Documentation: KVM: Consolidate notes about kvm->slots_lock and irq_lock
      Documentation: KVM: Turn - into bullet point
      Documentation: KVM: Explain what rule the exception section is meant for
      Documentation: KVM: Have actual headings for exceptions
      Documentation: KVM: Drop mention of kvm->lock in SRCU documentation
      Documentation: KVM: Add example for kvm->srcu in relation to mutex/lock
      Documentation: KVM: Document synchronization for managing guest faults
      KVM: guest_memfd: Clarify comment about gmem.file vs kvm->srcu
      KVM: mmu: Point users of host_pfn_mapping_level() to docs
      Documentation: KVM: Focus acquisition order section on preventing deadlocks

 Documentation/virt/kvm/locking.rst | 173 ++++++++++++++++++++++++++++++++-----
 arch/loongarch/kvm/mmu.c           |  24 +----
 arch/x86/kvm/mmu/mmu.c             |  24 +----
 virt/kvm/guest_memfd.c             |   9 +-
 4 files changed, 165 insertions(+), 65 deletions(-)
---
base-commit: b7fbe9a1bf9ee6c967ef77d366ca58c35fcf1887
change-id: 20260527-kvm-locking-docs-3c6dee0fabce

Best regards,
--
Ackerley Tng <ackerleytng@google.com>


