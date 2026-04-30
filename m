Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB295370D71;
	Thu, 30 Apr 2026 05:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528246; cv=none; b=nh5w9tmgcUNJQg0YiK0TZuFkWxfKMAe9vvsWxgl7PB1xfcVQWnPK00ziRRZOD0Xit3lz73JnlUSCOym19dZOM7Sjd5SUyXk3UGMr44RtFAuwNKbS4IBzKBO7bWTZam+E/QrNuC5xDKC/VT03x/Rtupqy5sJna3o5I5rqgyiq6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528246; c=relaxed/simple;
	bh=J+5LNB2VNY73hYQDaK4DNgHv1tsHZKUBzanjAr72QxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUZ22YF/0LuoxKfDhpvODS+biEVo7ILHs1mfXPjeKAjl8tTsqydqIJ0T4yy+xIu3Yo3+YQmzXha5o/9dyCTSlLzFrSWj0GwJbmHy4bldPFgJWW++fzRaocuf58YKDs1uU3TyLC/DEKZ9c1gCLxLh2vRRpdSa4WKh1RNNedRpAsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EUvm/qjg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EUvm/qjg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TLdf7X3991826;
	Thu, 30 Apr 2026 05:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zux2iqmTVMoxCwd+G
	glwc5wsABaBBuAJANF/lFJMKzo=; b=EUvm/qjgmAo0X+WglVWZuPQxUssZB4o9J
	Zq2BC4XmjtJaaXqBKy3cCntJecGEaCAC3M0xCZMHmrem7xBZQWT3fIAzqtnyJSuK
	ky0WI5r4ghEjjmfx04C3/hw97Ps7TZBH3+jyqphgltsNFSlitxjjmbaSGPuZlWwl
	h9uEdAatEAZvwcnCgiQMZIdejQSTH4pKRhDg0JgyCOpePIXffzntmcJqrYHVo84B
	Yp0lrxI+2C8+Fu64hBI7YzuYuA85Ur1qz7RWQj9Tf3AUZ2WaQ4y3RQt+cv2GeOi7
	Z/RtyS//aL/4EVHBgYrZ4XKGXMKPkkY09H7qziKmVjhlXNiDRU5Gg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44x6yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U5cuB9010311;
	Thu, 30 Apr 2026 05:50:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyhbgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 05:50:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U5oUP159375972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 05:50:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6AA720040;
	Thu, 30 Apr 2026 05:50:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 838AD20043;
	Thu, 30 Apr 2026 05:50:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.18.70])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 05:50:27 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] KVM: PPC: Wire up KVM_PPC_GET_COMPAT_CAPS ioctl
Date: Thu, 30 Apr 2026 11:19:02 +0530
Message-ID: <20260430054906.94431-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260430054906.94431-1-amachhiw@linux.ibm.com>
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: N0YytoSHj77IpD60dC_KIuO930sp6Edt
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f2edab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=MxX2ZhQXYH6PMiHjArUA:9
X-Proofpoint-GUID: sw-Vb_Bk0h4TjseRr9opP-Lf-6-iNc9W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NSBTYWx0ZWRfX3gmRQYD5fkIn
 vNhXoFnroncb91SiAm+7A94HI6TYd0LYMaN+0mAutviOSDPcqnYi7Lvvi4cD7CDKx/zT5bpvdd4
 Qg+J+onkN3h1rrC37IuUxjxIIe2o0fb8l3pObujOR77Tmcy+55PNZ+QM5PlVGHvyH66bmHO+4Jr
 cOG8npEIqUFBR5w228nYrby0eA1Uo/0ncLdYLDgub92PFbaenb/SkkgoeaXXJVWrkpxlgJ9vlre
 JAOz/G8ljjj+ENBFJcN9CUnKBdfyfItfSrutBp1+cpHDMeExuJqdSA7VusNcluwS8rLIRgKE/cq
 Ug0WZcOawHkYKG4YxEfMuPMDmtJnJJWz9UjzgU7QVdkC17Y3is+PUVR8l6AnVhy6T2nqIvB9547
 BVeTaADZrR4hosWPH/gExMHYh/mUiEmtjywSouz8c1Bch+uhap9kwUiOpxwTsPLJ16n8b3h5ghu
 9EMJ2Lw0yGAMJPwZ6fQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300055

Add handling for KVM_PPC_GET_COMPAT_CAPS in kvm_arch_vm_ioctl() and
advertise support via KVM_CAP_PPC_COMPAT_CAPS.

The ioctl retrieves host CPU compatibility capabilities via a
PowerPC-specific backend implementation when available. If the
capability is not supported, the ioctl returns success with no
capabilities set, allowing userspace to fall back gracefully.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h |  1 +
 arch/powerpc/kvm/powerpc.c         | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 0953f2daa466..cadfb839e836 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -319,6 +319,7 @@ struct kvmppc_ops {
 	bool (*hash_v3_possible)(void);
 	int (*create_vm_debugfs)(struct kvm *kvm);
 	int (*create_vcpu_debugfs)(struct kvm_vcpu *vcpu, struct dentry *debugfs_dentry);
+	int (*get_compat_cpu_ver)(struct kvm_ppc_compat_caps *host_caps);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 00302399fc37..f35017d83d77 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -697,6 +697,12 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 			}
 		}
 		break;
+#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
+	case KVM_CAP_PPC_COMPAT_CAPS:
+		if (kvmhv_on_pseries())
+			r = 1;
+		break;
+#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 	default:
 		r = 0;
 		break;
@@ -2463,6 +2469,19 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = kvm->arch.kvm_ops->svm_off(kvm);
 		break;
 	}
+	case KVM_PPC_GET_COMPAT_CAPS: {
+		struct kvm_ppc_compat_caps host_caps;
+
+		memset(&host_caps, 0, sizeof(host_caps));
+		if (!kvm->arch.kvm_ops->get_compat_cpu_ver)
+			goto out;
+
+		r = kvm->arch.kvm_ops->get_compat_cpu_ver(&host_caps);
+		if (!r && copy_to_user(argp, &host_caps,
+				     sizeof(host_caps)))
+			r = -EFAULT;
+		break;
+	}
 	default: {
 		struct kvm *kvm = filp->private_data;
 		r = kvm->arch.kvm_ops->arch_vm_ioctl(filp, ioctl, arg);
-- 
2.50.1

