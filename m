Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B757239E6C
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310053; cv=none; b=gfZMzq0PStRC+YKVfop00qA3ooxQLJp+BlBuTQuTBxkzayFnnJCiS2LpFE9BGFPqYudOgZ95QGgU4pTdCJchYLe+ZZCn72CIL0plWrmN4/kjxKSbnc8UpKzw48cvLw9LmSmLSPI9pE/t92ZBigWc5mGxJfNWr0G7csgi3r46LkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310053; c=relaxed/simple;
	bh=IiGZmkWT3WPoZ6HausMiysXDwCuAXCHgmfEkSM2GYJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BkiEZ2+ROfTGGJliDaZL4o4vQG1ElQumZ35AjPfya5/sKLMX0vkRBCcw2mcCdYpED5HLEC8j6cSEJpoRU6QOwgVEttqOCPh7jgW82T1+qNSlR6ssymGbQSrrhfReFgGiyqRLb/p3pouzFr9Gk7bbBJhf4FfEu5kEZoxue76FljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mNss6TVV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNss6TVV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8599ebec31so1478470a12.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310052; x=1781914852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=q9sUY/ENZfo/yRx5ubG6cRB6yRWSUsHWXW31a/Wy3XI=;
        b=mNss6TVVYZPBGaGWN7FqyFj1usb48EpazBErmUwcGuovPFpqXPeo0oW8juiLg7T2Ea
         kdns6Kg2WHoxacgzR+Vna82c9LdyydVT+qViTXkKgtGlP2zW843t0KSITRev8Bgf1PCB
         bV+Xi5rkpnGYn9ycpHw6708lN19eBz/A4d9x+akhV1u19Che3EkO3+ewtwGZjt69sIBQ
         ukLMAenjboTJLPBCeWcab4VqLWOug1ShNMc9ExoeRXbN9GPyRCA6IRuFG/98qJNYrOAI
         O1kQc9zslTW7cPoiAmyinp4kxyjJXWdffXRdKjoGSgtRML7QWEtXc4QvGhfbXm16lUem
         KNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310052; x=1781914852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9sUY/ENZfo/yRx5ubG6cRB6yRWSUsHWXW31a/Wy3XI=;
        b=jEsg55rKW/vkF8+xz6wxuxzK4r3dAZg5RC61M+HmmgD2oFc7nLVIDIgvflSwmX4LDw
         DQ/ujMxpkFGXwgV3DT9MVrYq3odAKpxaVvJuEKJUNEpPT4B2m8Wylv8fXPGJPTlcOyPw
         oJE/Ovfn9aE0ITEzqmJakfbNULe3NAZ0zWVqbEMzvjtoacVLBJmXzeL6oEVz4lpF9SXH
         TPs31SfWzqymIPWRlLcU+rNqX02QeBfWESLtj0Z8xU/LogxDmjGCHsI2iAiq4z9JtsMY
         uWFX192QtVH/wl6DwGhD7TwCZEVEGt4aI8K207DMBGSHwvZ19URj+ud3lEBvyFGOiqn6
         PWWg==
X-Forwarded-Encrypted: i=1; AFNElJ9lqVDcPItuIhHU8nCEkb7us09yfA6ImNBwM7vvuWWAuh1+PGOpahThFnVF3Ae3l3y6xFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCt4OPXgddJj0L2h2MpW0OuCgWrXk1XJV6ELsa8sTL3GKIDdV3
	fjXZuIxA23N94o23xET2wIILx7/AnDm+LauNFSp0RMm13Mk/+D6UkCt1kQh/abwIQKkWFgCyN/5
	7X8vQbw==
X-Received: from pgpd17.prod.google.com ([2002:a63:bd51:0:b0:c86:13dc:1ee6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f87:b0:3b5:6b5a:4f29
 with SMTP id adf61e73a8af0-3b784012441mr6057241637.30.1781310051467; Fri, 12
 Jun 2026 17:20:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:24 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-14-seanjc@google.com>
Subject: [PATCH v7 13/20] KVM: selftests: Make number of IRQs configurable in
 IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Extend the eventfd IRQ test with a '-i' flag to let the user specify the
the number of IRQs to generate (instead of hardcoding the test to always
generate 1000 interrupts).

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 2356912e2272..2cfb6c24e8d6 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -134,12 +134,13 @@ static const char *probe_iommu_type(void)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-t iommu_type]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-t iommu_type]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
 	printf("-a	Affine the device's host IRQ to a random physical CPU\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of manually signaling the eventfd\n");
 	printf("-e	Set empty GSI routing in-between some interrupts\n");
+	printf("-i	The number of IRQs to generate during the test\n");
 	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
 	printf("\n");
 	exit(KSFT_FAIL);
@@ -174,7 +175,7 @@ int main(int argc, char **argv)
 	struct kvm_vm *vm;
 	int irq, irq_cpu;
 
-	while ((c = getopt(argc, argv, "ad:eht:")) != -1) {
+	while ((c = getopt(argc, argv, "ad:ehi:t:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -185,6 +186,9 @@ int main(int argc, char **argv)
 		case 'e':
 			set_empty_routing = true;
 			break;
+		case 'i':
+			nr_irqs = atoi_positive("Number of IRQs", optarg);
+			break;
 		case 't':
 			iommu_type = optarg;
 			break;
-- 
2.54.0.1136.gdb2ca164c4-goog

