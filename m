Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187281;
	b=RTJGqROaytVWN5iOFgTFd/HFFqBAcempezevJNPk9TQ1LJdrIDbfu4+TW4+F5LTis18J
	 DkMFFOW9LMy5ArEEx1cuPyc42S3hI937Kn9uQUfEk0nzQsNYcXxkhzH0JEw98R9Iu0Ywk
	 ESYn+b8HCYLYKpLLHGx6aGJj2bTVKQc42caaswYqWT4MCm7mvRFwycCLNqA48PFa2cMpJ
	 vW+M6Zs/bYVvoZobRFy6i/A2SJn9lKZCub1fwgRbk6Whtb2sxpuhIOjAmfD7kctQxnnKn
	 /ex4NhKeN6Bh7IBo0VKhQwV9aiHxKQZmDLQ65dHP0P17zdk/suCjOd4YgTdXYLoKF2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187281;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=BxDhP/5FAQ5VWdRRHlkDCKig9L7gezWwXUkQaosCkl4=;
	b=MTSMKYn/q3zPnxKmwNDO7oqk2g4ye+MQtiXhAVaRZXgxO+Q+lcLQpEJUPiVb07hWJgQf
	 BCAgMrZ+MEnDVc0LLrX1ezPnR+h8JIbUEgnDyeZ1SKZ96GYWG0l7qoFwlesQhupRwJ9Cx
	 KuB8LKP5fzB2gEnMh4BjfbCuJGcyc70WzzbdkCn41su85q0hFoAOtts18QNlRVlSojMkl
	 GZqtHiTdnpiajmTs/xCEhKXr6Eu/KElra/mLKego/Pe5qSh792OroPyPKNikcia5ouN8Y
	 8F5P2ZfDZAysv0fDITUwetPVQxxFurZ1PWmMOPEF7DLy+9q50MNNc9RAhOb1k73IDGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=f5HyYbHG;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71401606A325;
	Mon,  9 Nov 2026 01:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71401606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=f5HyYbHG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BxDhP/5FAQ5VWdRRHlkDCKig9L7gezWwXUkQaosCkl4=; b=f5HyYbHG+7boQQNJIRCPSm7JW2
	6zOJSyN2yGjXm6VHsuXMMDnq2XIz+z6VnZ+axV7TqzeDNfdNzHgm2tv/RMVnsN5gMbfLYbFfHDL1G
	eIwr69Aod10j7TA0Wx3rdNLLfLfJCsdOCUoA3VotmJNYEsQikWtFOvQrVYt510sN1tqhCroqCw8kq
	OIqtL3DEFR7qhC350Af/tsocqk7qi8BC2I+ZIQJ89ZkYY+t9QqKmlyfbzg0yi35oP3sYNuqC5v0El
	3lsG4Qelh5vULim8Zd1UcRR59P8XyhXvH9RaJ5mgSRBpr21SrZOxNHIBXjgrgD7+3O4kta9BfG4IC
	foaabdRA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQE4O-00000007Pvq-3U5n;
	Mon, 09 Nov 2026 01:21:12 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xQE4O-0000000EKUM-2ex1;
	Mon, 09 Nov 2026 01:21:12 +0000
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
Subject: [PATCH v12 06/24] KVM: x86: Avoid gratuitous global clock updates
Date: Sun,  8 Nov 2026 17:20:52 -0800
Message-ID: <20261109012112.3415328-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109012112.3415328-1-dwmw2@infradead.org>
References: <20261109012112.3415328-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

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
   shared. Only request a local KVM_REQ_CLOCK_UPDATE for the vCPU's
   first-ever load (vcpu->cpu == -1) to generate initial pvclock params.
   In non-master-clock mode, keep the global update to synchronize all
   vCPUs.

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
index ade7e71eb57f..0348f24cfd1d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2723,11 +2723,13 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
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

