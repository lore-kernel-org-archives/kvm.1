Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420578;
	b=Ddr9aWcA6Fj+IvoecjfH3/4NcH09UqMpxGpFxbXDMRupLqydM0azQVqhD9Kudz9DFVi1
	 gGVqFtZDQ0zzUzDX8/Zgn5LSzdGg+CGXxeadGu+oIDciW0sUI+Twv8mymujcqe9tBzDSv
	 f/rpHGHDN2XUwiX0HAsQkEG9IRhCbEQ54bEcCfyiDDKSWI8S1+0frBO0u7uWoJjtPH8n1
	 dgjtrOMU2PXnMN8N/M5Mso4agFR0vEIEkpassHrfxhlWBN8q6GE4jE6zHsUHidnfc2M6k
	 LLYJNSywLHuWARMmWYjFCMVKCt3MEirLLyjgdHd9X/VvY6+Oulbl3FS2Ma/DFMiadvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420578;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=LSt/cjhlDC770FmWw8fWfoUicf1cn/kr7nVQwqL5nQg=;
	b=1movd8RP1S12Nb62wuKrAh1dPA8tsngYEDevUch0hVKEe4Cn/NTqtZwj4lHhS1xkXNQE
	 IrQflxHFWI6QPnNQuUo1EjQQc3xHL05C296lZwPv27d0Nqy+5KoKO8tHKr5pb4KqTUKUV
	 d1GQyMiOOXI++Da85GF7/GTGGZTlFoqtK/YcqIcQ9lMel8zrZ3NWPzX1GRsCFJlXR35O8
	 btapYgUlG6ahVIxNTniboxskP3aPUdo71dO3N6AnWAbe/RHNkWat5ZZQlEvLPEHhNYvpd
	 1jatxBh/JoMhnjB4bo4Fw9BUSQWFyPVzp5GB2m3CqBy53eRVG6Cc1/GfIlRS3QxFnMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=XFVltFAe;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36761606B782;
	Wed, 11 Nov 2026 18:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36761606B782
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=XFVltFAe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LSt/cjhlDC770FmWw8fWfoUicf1cn/kr7nVQwqL5nQg=; b=XFVltFAeYxoNTn5FfTG/Gzl+Uy
	YeeyxrmNQNk3RUAfiuN66ThENH2MmsIsD1tLoAUi25+FQeox1j1MMkKnc4K0OOZBancz4LGBfsbsB
	nyg86quK89q0/WHluHa8aeqFojee4KhnnjLOQ1B3seVqf4iK95/GdrilUP+xpSi5hCqKajyoY7W2Z
	o+VUcs0PmomoSWb+1KzNCUys1UcAZGREY5AA/G6mwaZpGI0Z9DL5/Nyad0KVthVsGLSe+Dm9p+go9
	lnmlAmplFXCGlgY+fEajj5ESFioyTFuypp8TFUS+3G73VeG+hccf/CZAClBg+DH/ISn31RoixFHvk
	0mNX1xMw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClB-00000009PvL-3C7G;
	Wed, 11 Nov 2026 18:09:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWsO-01EU;
	Wed, 11 Nov 2026 18:09:23 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v13 06/26] KVM: x86: Avoid gratuitous global clock updates
Date: Wed, 11 Nov 2026 10:09:02 -0800
Message-ID: <20261111180922.4177927-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111180922.4177927-1-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Eliminate two sources of unnecessary KVM_REQ_GLOBAL_CLOCK_UPDATE:

1. kvm_write_system_time(): The global clock update was a workaround for
   ever-drifting clocks based on the host's CLOCK_MONOTONIC subject to
   NTP skew. Now that the KVM clock uses CLOCK_MONOTONIC_RAW, the clock
   does not drift with NTP corrections and there is no need to
   synchronize all vCPUs on boot or resume. Use KVM_REQ_CLOCK_UPDATE on
   the vCPU itself, and only when the clock is being enabled, not
   disabled.

2. kvm_arch_vcpu_load(): In master clock mode, migration between pCPUs
   does not require any clock update since the master clock reference is
   shared. Only request a local KVM_REQ_CLOCK_UPDATE for a load with no
   prior physical CPU (vcpu->cpu == -1: its first ever load, or a TDX
   re-association) to generate the pvclock parameters.
   In non-master-clock mode, keep the global update to synchronize all
   vCPUs.

A host in non-master-clock mode because its TSC is unstable still
re-anchors all vCPUs through the global update in
kvm_arch_vcpu_load(), which fires on every load there. What this
deliberately no longer covers is a stable-TSC host manually switched
to a non-TSC clocksource with pinned vCPUs, where vCPUs anchored far
apart can skew by the TSC calibration error over the elapsed time;
the removed broadcast only masked that when a guest happened to
rewrite MSR_KVM_SYSTEM_TIME, which a running guest does not do.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/msrs.c | 7 ++++---
 arch/x86/kvm/x86.c  | 4 +++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index e91650af44c2..a2dffa1c706f 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1285,14 +1285,15 @@ static void kvm_write_system_time(struct kvm_vcpu *vcpu, gpa_t system_time,
 	}
 
 	vcpu->arch.time = system_time;
-	kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
 
 	/* we verify if the enable bit is set... */
-	if (system_time & 1)
+	if (system_time & 1) {
 		kvm_gpc_activate(&vcpu->arch.pv_time, system_time & ~1ULL,
 				 sizeof(struct pvclock_vcpu_time_info));
-	else
+		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
+	} else {
 		kvm_gpc_deactivate(&vcpu->arch.pv_time);
+	}
 
 	return;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 9ad217e8640a..05c801973a7f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2765,11 +2765,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		 * On a host with synchronized TSC, there is no need to update
 		 * kvmclock on vcpu->cpu migration
 		 */
-		if (!vcpu->kvm->arch.use_master_clock || vcpu->cpu == -1) {
+		if (!vcpu->kvm->arch.use_master_clock) {
 			if (__ratelimit(&vcpu->kvm->arch.kvmclock_update_rs))
 				kvm_make_request(KVM_REQ_GLOBAL_CLOCK_UPDATE, vcpu);
 			else
 				kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
+		} else if (vcpu->cpu == -1) {
+			kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
 		}
 
 		if (vcpu->cpu != cpu)
-- 
2.43.0

