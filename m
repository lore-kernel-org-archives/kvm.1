Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FD46AF38;
	Mon,  8 Jun 2026 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930546; cv=none; b=kna08LVeFNOHtqhzk9u2afjrsYOAtC5ZCC5HAZ7k5bO1KNFarPrRn9ijBMoqbkeE5u2GjsNpnxHPZeqqoVHOoL8j3O4b9rxEmXkTa8m26V/ViKVrvoI+g9DuD80TfIMY27j1flY2f+aMuyCEe1dvIql4B7AmvI5zWFFwhdmtRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930546; c=relaxed/simple;
	bh=YKhhhht+zbPfyPeyUv12YljkVrKSOCIavpgHT4Fk81o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BtBgaFAML09a+0OTAOFjAL1aKGoeICEhsSJE8yPuxXdAguQwJBJNbjMvlGZzJRMMtA8N36EB0AU3AtRx7dWbUfdNXZ2jDQRZtmISBbalL1+onfS5w34+wbb70wWCCm9YZk/pjehp8mZ2GSoSGLFHKopR+W+4RSYU10Sp+eHOtvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VFXvohgL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VFXvohgL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=ssc2OYJnjVRJZfXuehVvSyJIF5UAgdCRis7RcurFUak=; b=VFXvohgLy6g/BbZF+sYaQENPUm
	yEPrtvWhoUEP7ysZ1jL03TlZvP6/mte7iIouk1LvPyagfBknLxDiPAtS0pMgyLk73UBWYMZsBhBJk
	QSxMDhNuZUb74U7gfaFlkjyOPkmD2kDZCIqJ0BGr/KqQ3cXnaY23jHOrMeNLQwiwvDnQlxEAGVPC1
	XfEeXu2OiCeBVXeGu3N7Ay+yzO3K1yXv0OlyXvOaSVBDHHfbEDttdh9ymYTwSs2+6HWSijid365+Q
	peOdhFh+s8x1IvBj/iAOV4v/3paFNbtKp+GZDFVrHvfSKdYU0WaIDXKGQiD1buYYfynh8dUtGADr8
	iUbu1u3w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNV-00000001AgR-3WQp;
	Mon, 08 Jun 2026 14:55:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNT-00000000NGi-06LB;
	Mon, 08 Jun 2026 15:54:59 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 32/34] KVM: x86: Compute kvmclock base without pvclock_gtod_data
Date: Mon,  8 Jun 2026 15:48:13 +0100
Message-ID: <20260608145455.89187-33-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608145455.89187-1-dwmw2@infradead.org>
References: <20260608145455.89187-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

get_kvmclock_base_ns() needs CLOCK_MONOTONIC_RAW + offs_boot. Compute
this directly rather than reading offs_boot from the pvclock_gtod_data
private copy. offs_boot only changes at suspend/resume so does not
need to be atomically paired with the raw clock read.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro:claude-opus-4.6-1m
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2713aebb96ae..c18947c5b63f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2402,7 +2402,7 @@ static void update_pvclock_gtod(struct timekeeper *tk)
 static s64 get_kvmclock_base_ns(void)
 {
 	/* Count up from boot time, but with the frequency of the raw clock.  */
-	return ktime_to_ns(ktime_add(ktime_get_raw(), pvclock_gtod_data.offs_boot));
+	return ktime_to_ns(ktime_mono_to_any(ktime_get_raw(), TK_OFFS_BOOT));
 }
 
 static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs)
-- 
2.54.0

