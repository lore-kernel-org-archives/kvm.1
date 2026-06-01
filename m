Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CF3939D0
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309596; cv=none; b=Jy4Mbgpkpoi8zg9DD87+b2QF3JcXxHXRcZwCcEFlx34u4bRPS1fyz9Gxfmx5yZg8XtXx7n5pKENzajmnTwbmOjH8wLE2zPdWQ3HP4d7AxLRydlybeJvH+yAc3AeIMfWlIH3EPYyryZetZ2sZNc7F04qjvx4qju0wBLKgOAqgNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309596; c=relaxed/simple;
	bh=XMF0XSIyNuy4j6kTqZpEJUq1eyLTItJ7528vJLaFCY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIsBvAWqbiJrgBn5Pir7NMInX2IRLB8rGuBpo7YEboe3jBXf8nHACHY/vfrXdmsrb48lr6v37unXdKtPVpobfMNMPZWN2aoEfkhyY6J0wkOYzQ6ivaO8J5jHdzzlv+8N5nmQA4Xw18TeaQPg9oHrZxyjAIwKRjISTi1QgH4lkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=d3SPjfug; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="d3SPjfug"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1363fe80fe8so11688737c88.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1780309595; x=1780914395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZcJSSPPDZRD9m7u0WYcrKJNavTPlRfNheNSPldKeYQ=;
        b=d3SPjfugQCk4xguTPAWU1vtSJw4WSrPiFInVIS2jafqsTwYa5ZP7iMqXr+F0mlr/NE
         3QcoPZYorAE92oXUb09M0locanhJSCVmVjzZ5fnnWEsAyf178OQpeWZ7XxSzyCzckwaK
         epVJ9am8o9atmfysJjlAUq7RQkYUWnAU00tHBp3kvJMdJea7CdLfBpJ2qekqx8kej1FU
         5y6oO0bVvbSHRg7qGU7QH7mGVgMUOK/VbY92q83YawMuzETTk+kGrUuCYP1KZbEwgCNv
         gArNf0RMuMSWaNZTHZ34DbpH0e2khdOSZG+GGGc5t6+p38+ab/q5+3kFZOFGTnctyDSQ
         wsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309595; x=1780914395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vZcJSSPPDZRD9m7u0WYcrKJNavTPlRfNheNSPldKeYQ=;
        b=IIr6ZJxkcfSrum5+pLNpgRhkbJg3mUQv9fcGtLMccJiL3xxJU2WQAAPjJFKd9ZROaB
         5f3DrqoaWDIVaHu2v9AwD0Iq+oYYsXiDenHWm54mLTiX1Tgfaly9jpE6VNIQ++CBqjNH
         2/kWrHvxXe/qVCVzILcOcn8uI/GXDOW7WCnlFttjcwu7wNEPncX+A9XkCY6zcc+YaqZp
         Nob41DjddDJ9DI1BxzQhTZh0FggKFkI2SgG9Tx+ML6zsxQoxV9V9m6Wt8ouCWOddgJ81
         q5guZiJnXT6RnnuygTscvDc+Ccdlvx6mrq+HQtsck1AFTkAfUYLBwenSIAv2lsshUYgx
         wOoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dbdrShUVXcdB6jaxiwiaYDALWYIBvueMVySBKQ9rqvIpunMhgfyFoZCD6uJCb8tscU0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tk+Zrr47vacHgZcBXRPYy4BDWI+tubetaJmbLZZvaylbqqnA
	v5lIbnzcq0B+Dm4pUtfKjJJDOFEx0Df23tAABlLAaBabnMB34Nt66qyaQBQo0M/KpJg=
X-Gm-Gg: Acq92OEHHCUhPWLyw5Z7Zm4HgEY/pyoaTlwRpib5zhIFc0qyOKlJ1BebEGGcZyEvbFk
	9Unpx24NtAeAse3jgXJoay1qlQ3tiebATH7sha1Hy8dLtY31lDBjvuCFcCKZET4LYw1ld3mrHDq
	HcY+AmOPVcfR0X5ih8KBP5QeTHo44r+WQBVkA9x8wXOa+ibOFcv2Fdhx4QBwmHypbDWP5rpkftl
	tn2a9MWBxD0XU9RtHFxuvdV0Bj23pKI5hU+pd2HdfwL/sN37asjj5LMBzPou22CFg1IxyXf0i4Q
	h1O2MF63qrrG8BLun7ABKvr+V2Cs20UFVS2eyDlok/9iwkh1ncVdvVUtL+PSEZ5h8ASwUGQkEvF
	45vNKXAvlSygRAZFWIL+3ZZ7X9Qv1xefssQY8CPMtp51Y2FUg6pO7h8+Va+T7ncmsREbfqavG7V
	cOq/CLe05P8zvJR/mu245v3eaiTvlonBmQF5kS+Xh/0RrGK53sJmeD2w==
X-Received: by 2002:a05:7301:1695:b0:304:de94:1c2c with SMTP id 5a478bee46e88-304fa75092dmr5279923eec.34.1780309594882;
        Mon, 01 Jun 2026 03:26:34 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5b9be7sm8176001eec.27.2026.06.01.03.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:26:34 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 01 Jun 2026 03:26:22 -0700
Subject: [PATCH v5 1/5] KVM: RISC-V: SBI FWFT: Mark vCPU CSRs dirty after
 setting feature value
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-kvm-get_reg_list-v2-v5-1-415d08a2813b@sifive.com>
References: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com>
In-Reply-To: <20260601-kvm-get_reg_list-v2-v5-0-415d08a2813b@sifive.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, inochiama@gmail.com, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780309592; l=970;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=XMF0XSIyNuy4j6kTqZpEJUq1eyLTItJ7528vJLaFCY0=;
 b=i4mw/AFm7VlveGu7MUnkidG4GqKblWsIvDKpDapvBtMbjsymQ2BViwqrFhpQVOJj/B8/0HHfM
 1eIuk0srt6vBTpBQi2sl9VIkC6pNQBVnanp9bwOiLrdd6aUCUVh1h+H
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

Mark the vCPU CSRs as dirty after successfully setting an FWFT feature
value. FWFT features may modify CSRs (e.g., pointer masking modifies
henvcfg.PMM), and failing to mark them dirty can lead to the guest
observing stale CSR state after vCPU scheduling or migration.

Fixes: 1323a5cfe52c ("KVM: riscv: Skip CSR restore if VCPU is reloaded on the same core")

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 arch/riscv/kvm/vcpu_sbi_fwft.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
index 2eab15339694..5e4aafb0cbf1 100644
--- a/arch/riscv/kvm/vcpu_sbi_fwft.c
+++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
@@ -521,6 +521,7 @@ static int kvm_sbi_ext_fwft_set_reg(struct kvm_vcpu *vcpu, unsigned long reg_num
 		break;
 	case 2:
 		ret = conf->feature->set(vcpu, conf, true, value);
+		vcpu->arch.csr_dirty = true;
 		break;
 	default:
 		return -ENOENT;

-- 
2.43.7

