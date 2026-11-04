Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.6.135.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827531;
	b=HDdn0bY7l/G73sGQzx0ayr0BshecibzoQrQWaGPnLrNwoHtg7fN0wQtXn8r8WgIauHHu
	 dN71slFB4umTQg+TeEcton7hJ0L5B12W9MtiVYd2QtKgllAWW+N1mUblaBQkL9I7ur1yR
	 1XgDRzXFwNW+dbccGmCMX5CS8hPYBhW2Z109k5Ad8lLSNa7gFTJpciE32rwhWkQtX0Kiq
	 ekEUGKzrmpqHXiwFTXkdg8icWXAYLdMdjzjO9Iu6Jn3dKHdJI0b0XT4AqHhM3F/CbTvuL
	 7knxA1u/8rIj/UzuWhOrFr/GZF1gGihFWw7RE108LCRtOv2jAly4QQ0aWhYDJ+xCM4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827531;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:References;
	bh=oiHsBoo4ax+JXNIAzYijKNsPhYtjWF/GsFDXyS6pIxM=;
	b=S9i6yXi/z1Qvcz3pDXsULlUNMJmL2BU5v1s2XuRlfkZf0Z/lQZOaYH5jfE6VzlHo1hhS
	 nND5NF6O+MezUxp8FDaupO+TZeRJIm06YjDOL64B8NC9BjAShC3Mw31KJ68o5CVCVD0uu
	 Ikbl4n4oXWzOgf459Fr5uCw1rx+ZgXwbmniiyW91rQOb5LwVNUd3fUxkuLk2nz8XtrCqE
	 KShEYaqxRHwU28QcWAzCB2Hu0TrlhUdRu+kgtKxiH4Jhul3UOt68+AH3F+pCNir3mqS0H
	 DxaLU8U8PMhrd49RcSJL02xfofWc+dA9OxbKW9Vt6/CBlptLfJ9obE0pVXgRXRfa8gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=EAzI9AhA;
	arc=none smtp.remote-ip=74.6.135.124
Received: from sonic310-14.consmr.mail.bf2.yahoo.com (sonic310-14.consmr.mail.bf2.yahoo.com [74.6.135.124])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5BE606BA30
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 21:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B5BE606BA30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=EAzI9AhA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793827530; bh=oiHsBoo4ax+JXNIAzYijKNsPhYtjWF/GsFDXyS6pIxM=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=EAzI9AhAz849W/733rXBHW8LtMG/exgch0h+bjEEHpDZliKHXU3uIeHY5RRTB7212YB2AqMrSRbir4DVQlUZ/qEk4f56kM3AL+BBquGRLiZIK7fjcRx1jKvHAWheH6QjCqnMOzYNfxhz8twyCDcxwUo5c942ldvIolzGXSvU/XZUPz+32KYi8HUo/uF03JAA8ffmD+volo2qVMPKnPPFghibIU6jk+wKIixZOIXSiz7wo8A5SLNoru8Ed2P2//P9fa1W/flAA2RpUmEuyiAHoLdSfbaAPu8aNdgWybymaMqPn2mKG/Nj5YeU0bFPtjpXYRL6dMajPF/AaoyoEGW4pQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793827530; bh=T8FhAh/tGtqnklh57gs8VmPI99D1krVO7QP7NijeW5A=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RZAOP73xbrZibaePOvX4rT04eV23kXQ3jmosnW7aOUn4ecs8WWCFEoj8Kg/tE7yj3kcohwR6hcNN9JSmqBBSSZIPGUlLTRBektBu6b57ytXxALKPiIqvWGeodZpz9QYWtBm9YHK8keznpkMjVmZKl8PSPv30ss9nZT+Wza172AXjPwvK3hQ8Q1DIGuVpOWpp4m3ijSS4V0W69J6wugeU7xhGnx2drN++ZEncSrD9rQcveGRzpBpQWQrfUrwCAS7YpmpMNN3Z1RxjFSdnJ2b5uQfAzxQ/j6Uj9Mdl6udIFZngiOipc9/mEHi7yE+EjQngL0rUWSP6SP+/VFhZiNKL2w==
X-YMail-OSG: TyfXkFsVM1n3wg2js5.bePodlOJjDVyOUoI1ejGE3eGugWgBZ9BJfnAiIyBQxDY
 09Zjftc7tIDuAKwh1enpWZ8kc3xrJIdEAZ4MIV58SEk7dz6A4oX5ZRs_oYywyIaP6jSRQFDREPdZ
 xxK3Nww59Jf6_n.1aXjgaN2swD5x5YeZgv1iwhpgx5VYZyN.hMH_pci02Mu7WYzmtEyLeIh5v._K
 ze17S5aNB.Uz9RXvKvJD4TJqxVK0MSHSRaeF99nxV.P8vaiTvOEfWDFv1hFmkYeRzv_ilXf9frS4
 S3cGQPS_nggRXW9hgnczad9dtd7atNdja.VzW5Tvdw3hhvxnP4Nin9bFP1pbE6xoQld4xAb5b1bk
 7ENDSveQD0UOO1QIe7jxWujVUQKr92DzB.rKlGoziZZcV.CXBxjTKgMeX1i3qvjOVgwQ3XuFcf.H
 myf3yPGdgIixUmgTRkQbkOykeg3bDIyOufHShxYd7Z_ZWKd1Dfm0WXlRnEs8LyUb1FO8IMaxbAcV
 6kb2lMkdMMorgOtUrUU4AxAX.2GKQ3ChR33HNA03kJhC528IcU88Cu4NMHAwfeWrQpqhMUV9J8xR
 RFBLglsN.MzUovb40wgXNVfEZNfLGZIqanf3GA5jlaum2ELPJizMDb7kJDe4jzNJFg4iCBkMd7HJ
 ViLfT4ireUn6gBrgtVsx6PAKKBCD.72F2DWn6C5IbClaeHEK8QOV_4LPQC4CSIQ658EJo7L0Pe3_
 vdLmk5obtnHMssHJhqA3.jDWkzw1qulrD_vdPSzs_a1kPVndbE84MQnKlJjbP8l_CH76rFH_F_tB
 9fdEAtMtUz983ip7NWU29XlJiqow6bg5QsmWhRlFhA5wRJbULIWLnX7LevZ2u_CTxwCWWqGB.TSU
 HScopYv4tAuhiT8wRD_FP0732Zbj8z4a8xGMCXokHNYha_eKBtYbygEboPFcROQycpVGkVRD29LA
 D7BJHAE62RR_CAbe0WSrx7itugZ70eJ97sa0_H6cSB98Yyr.jCJ7QF5pBl_eU.heibICW39Ppeh3
 PBS7NmAulgI19hSmc0cyqrfXnNA9AOaTVKLDozlNovJIct9ylQOn8dwJxrtA5Vv7XokOH9NMdNGK
 vtaNY_0wX9_2g30LNpSsS0xKB0kFj3ObQUXxRwKSOGGk7PGUt0h9vEVaPsWQOhCLiQNyN0ZJHeiY
 9hIKnLq5swjYF.efUVWMMRlOxTvgmmPMgc5jMph5ws4xp6dXxbQd_6QxURcgviK.OWa2vuGoW9vL
 WDYX_XuGi43AayUrlJCiDldTP6yM48lctk1OVSc.ZneJ8N3sMDOMLQFXCedi2IhhYZN4piNQE29r
 Vk120hCmaooYMpAtWJvTEKd9y2zt7xZq.JrTaUBs5WyhcDqxZiVymkFW_CZGqxYH9Rafrh44XBeD
 2uUiExC_bfA793Z7WCr4a7VSbUv_NPJGwAAlrtjevUHDv1y62rFHAuERfdru4HItnzkxE8qa2SQK
 s6hzCUdv3FWWsE2mHO0dV.eENKtskzhERBDREgXblNrofmcM7AeD_Pyn5IPJVZeej4dp.CMDqTUd
 uwXEhv.AdFdyalJvBc433KT_UgmaR0r9r2NUx1bIqWkbtuTwk7qn52FgMofCn4lzIGnIkGqE5fwt
 2KWa7tCXVwk6LD7.DmJpuqHyBjaC_jfefH78tUk1WRJjSop.xZVoOqtI1RQHqJMCZGMOaD7S.qeT
 orPK_NAAhY03VmGn16GUeSbS19TMC8eQy10RTuVJY6DnPJzKJR.MFqbUoHIS6NNX9O5H8T3.MCB5
 ozH_LJFqxRvj7DxUoX0XDWAQywH39jayLRRYOOk2ue.G4ra9umlaK45jP52n8mLDtwxKZ8XIsV7r
 t6npaHdix4GaRwpXrWrcsSJ9POq2fsCi4AiU_nZ_nqHd4fY_Xo7g18fVRYwyHXdNM2Mcyc1aEAtm
 LiH94LbcHwNt2Q8oCHDP2Z55flgks_oDJ.oen3UmqudZDDPlcHa9LJB4TJqNmIIwkeqWShruMgRL
 8yO3v2WiRRBo6Atstb1GikxkdTwaa9DAGwKDRxHF9oBsU4zcPx9pKeVUhxLQucu7CekPIfiOodsr
 dQ8WT6Eyd2DInXj9pL8dcZAo4HlO7EXnASnIpvJ4FKsGScyd9sbjKTY8elHecRE7Dl8s5u4FPP.H
 SDNcWdanHCESL3Ej0IO7XJPUwx0iYxFygZRZzT0_a9hmDM6ioRdcjHmWi2cLdCi18KvQu8DRfsca
 7wswaGx7ONaRWhNyVBqWzQhSK.VyEmT9tjO.t9hwtbLFxUC8b4KVpmayfYt1uaEwFAqG.ptIO6ND
 2SQ1x5Mkw9bQFFUKMY9YlAoUurZQ4K3ooIAJaPGm8N0A-
X-Sonic-MF: <laurian.iacob@yahoo.com>
X-Sonic-ID: 9a948739-927c-4462-b555-937ee80083ad
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 4 Nov 2026 21:25:30 +0000
Received: by hermes--production-ir2-5dd9bf4598-bgsl4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4b63819bc2b89d88a33bcf362e7f8b93;
          Wed, 04 Nov 2026 21:25:27 +0000 (UTC)
From: Laurian Iacob <laurian.iacob@yahoo.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laurian Iacob <laurian.iacob@yahoo.com>
Subject: [PATCH] KVM: x86: Fix spelling typo 'RECIEVED' to 'RECEIVED'
Date: Wed,  4 Nov 2026 23:24:56 +0200
Message-ID: <20261104212456.9835-1-laurian.iacob@yahoo.com>
X-Mailer: git-send-email 2.43.0
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
References: <20261104212456.9835-1-laurian.iacob.ref@yahoo.com>

Signed-off-by: Laurian Iacob <laurian.iacob@yahoo.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 26e7beaff8a0..fee193487388 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9129,7 +9129,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 
 	/*
 	 * SIPI_RECEIVED is obsolete and no longer used internally; KVM instead
-	 * leaves the vCPU in INIT_RECIEVED (Wait-For-SIPI) and pends the SIPI.
+	 * leaves the vCPU in INIT_RECEIVED (Wait-For-SIPI) and pends the SIPI.
 	 * Translate SIPI_RECEIVED as appropriate for backwards compatibility.
 	 */
 	if (mp_state->mp_state == KVM_MP_STATE_SIPI_RECEIVED) {
-- 
2.43.0

