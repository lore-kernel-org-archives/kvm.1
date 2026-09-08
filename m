Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D73803C8
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861968; cv=none; b=nlUzSbSP6q9Ls8ZXKzcI43S+wXQMA4BvYmLV8KYL1WMlz902AY5EXT3Gpnj+UF3VJjCrTvt+HhlW8Dqkjt7BB+nO9L04v4kRxdu0NQH7VtnA1/oSdK/undQbmj9KysqmqiMolrOQeE6xTJ8FPDIdIWPEn+FoWrSQHAWEHe5PL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861968; c=relaxed/simple;
	bh=N0MQn4fpt24h6h8SLSgCP+WfNsem+UBysijHm0dnP1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gIKPSL9yaZe0Jn+QdH1C3k8N7RUjINMyRT6SXRqplMu5DS4kJT4aBEaqus7j2KnZlGECus5hiz/GJ3/0pWZO6N64a3VilQtzgyew+XQP/IdksKxDa+7BMQWeF+lwHhjwcuoiCfgE6+uJAcSFV/9Qk145wV6wfpmlYu1B1a8leFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3YDtN3J9qi5eoBw--.22882S2;
	Tue, 08 Sep 2026 17:58:39 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [BUG] RISC-V: KVM: WARNING in mark_page_dirty_in_slot with dirty ring enabled
Date: Tue,  8 Sep 2026 17:58:13 +0800
Message-Id: <20260908095813.786-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.35.1.windows.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:zQCowAD3YDtN3J9qi5eoBw--.22882S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyxZryrZF45uFWUCr1Dtrb_yoW8Jw15pF
	WrGrZxGrnrJw18tay2k3Z7Wa1FkrZ3Cay5Xw1DJrWDAr45Jr18AF9YgFWfZa15Cr1fta1I
	yFWj93W7uw15ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5Mc
	Ij6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU56BT7UUUUU==
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiCRQECWqf0KYq3QAAsk

Hi,=0D
=0D
I found a crash by fuzzing KVM on RISC-V. The crash is a WARNING=0D
in virt/kvm/kvm_main.c, mark_page_dirty_in_slot().=0D
=0D
The kernel is built from the riscv_kvm_queue branch of the kvm-riscv=0D
Linux tree:=0D
  https://github.com/kvm-riscv/linux/commits/riscv_kvm_queue/=0D
at commit:=0D
  9167580a3495b659656c3e0f689c4b38dacb2fb5=0D
=0D
I checked the current upstream tree and this does not appear to =0D
have been fixed yet.=0D
=0D
I attempted a fix myself: the idea was to dirty pages against the=0D
explicit faulting vCPU instead of going through the per-CPU "running=0D
vCPU" used by mark_page_dirty_in_slot()/kvm_vcpu_mark_page_dirty().=0D
However, I am not confident about the quality or correctness of that=0D
patch, and the fuzzer did not produce a reproducer program, so I could=0D
not verify whether the crash is actually fixed. For those reasons I=0D
decided not to post it as a proper patch and instead report the bug=0D
here.=0D
=0D
I have uploaded the kernel configuration used for the build, the kernel =0D
crash log, and a patch I attempted to generate with the help of AI to =0D
the following gist:=0D
https://gist.github.com/6eanut/d3e017c17f7a5a144da90a6513773b2b=0D
=0D
If anyone is interested in investigating or fixing this bug, I would be =0D
happy to provide any additional information or help that may be useful.=0D
=0D
Thanks,=0D
Jiakai Xu=0D

