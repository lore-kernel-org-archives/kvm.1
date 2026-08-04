Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1422440A3C
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785842452; cv=none; b=BBGrfVdNLBkvEx26nvZ87SpFbvZVzELPCwM7a1UXBmMkF7Wsh6Rh8z08bMlPXb4Ek4d1WUSZ1yTs/a8Ww5H780GLDX8CFT5cjxCkMI//4bnDEDZJqTMptrFeztpx0D361y7lWEemEP7SB7PQ+dNM+ri1XdZ15f++Oi9rGYSCqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785842452; c=relaxed/simple;
	bh=XRdPPPO2hqRYZCus6bFSfmdOS7A257YA5jWpdDEAfbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKeNa4P0cUqpJCq+38okrNkzetoZx4iy8L86oMoIgwnefOT/GkX0m4AFmthi9UZzC3GXqeEq559uXO4kYOvgB6CvlfQJYWs3pQBgEezsytG7JhDFgD4uHO2x8YlULu3pwQV5lr8FHaPf3/vjZYNXtQUoz3qOEy7SL/UjB2yQ83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aC0IXmTK; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aC0IXmTK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785842445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mr5daeqt5fKnewbMpqWnCC7jArhYcGTBtc9ufR6IWo=;
	b=aC0IXmTKb/y72xq8c4DbOsHFjuoeBqEZl8urxWLO85s50bh3aPPyysG8b/9kes5/NqCI9M
	pZ5I4aPrvDZENGQNbb6apV7kkWxlGnicQAkt5/lBDFzIpWKFNkhsZiehpBv9NLxpqOv7TR
	WKdg7NQKxjk0uHBWqswaQM/FwyssunE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: PPC: Use min() in kvm_vm_ioctl_check_extension()
Date: Tue,  4 Aug 2026 13:20:13 +0200
Message-ID: <20260804112011.59416-4-thorsten.blum@linux.dev>
In-Reply-To: <20260804112011.59416-3-thorsten.blum@linux.dev>
References: <20260804112011.59416-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=877; i=thorsten.blum@linux.dev; h=from:subject; bh=XRdPPPO2hqRYZCus6bFSfmdOS7A257YA5jWpdDEAfbo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmFp77Z2kR9rTBcULJgJaPtN8c6Fr81ScWiDObGGZ583 1VfyGd0lLIwiHExyIopsjyY9WOGb2lN5SaTiJ0wc1iZQIYwcHEKwES+rGX4zTpFdIHub2F5Ceb1 tsm7So19LGtW6pcx2igoNaUJL9mlxcgwRaeaqbNxp0LG/YczzLWtJ2zojD1X0bJ92vpfG58KLjz ABwA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace min_t() with the simpler min() macro since the values are
unsigned and compatible.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/kvm/powerpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 00302399fc37..f76322be907d 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -635,9 +635,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		 * implementations just count online CPUs.
 		 */
 		if (hv_enabled)
-			r = min_t(unsigned int, num_present_cpus(), KVM_MAX_VCPUS);
+			r = min(num_present_cpus(), KVM_MAX_VCPUS);
 		else
-			r = min_t(unsigned int, num_online_cpus(), KVM_MAX_VCPUS);
+			r = min(num_online_cpus(), KVM_MAX_VCPUS);
 		break;
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
